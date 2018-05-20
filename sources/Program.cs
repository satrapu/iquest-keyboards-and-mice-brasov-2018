using System;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Configuration.EnvironmentVariables;
using Npgsql;

namespace Satrapu.KeyboardsAndMice
{
    public static class Program
    {
        private const string SQL_SELECT_METADATA = @"SELECT 
                                                          T.TABLE_SCHEMA
                                                        , T.TABLE_NAME
                                                        , T.TABLE_TYPE 
                                                    FROM INFORMATION_SCHEMA.TABLES T 
                                                    ORDER BY 
                                                          1 ASC
                                                        , 2 ASC
                                                        , 3 ASC";

        public static void Main(string[] args)
        {
            IConfiguration config = new ConfigurationBuilder().AddEnvironmentVariables().Build();
            var connString = config["DB_CONNECTION_STRING"];
            Console.WriteLine($"DB_CONNECTION_STRING: {connString}");
            Console.WriteLine($"{"TABLE_SCHEMA", -25} | {"TABLE_NAME", -50} | {"TABLE_TYPE"}");

            NpgsqlConnection connection = null;
            NpgsqlCommand command = null;
            NpgsqlTransaction transaction = null;

            try
            {
                connection = new NpgsqlConnection(connString);
                connection.Open();
                transaction = connection.BeginTransaction();
                command = new NpgsqlCommand(SQL_SELECT_METADATA, connection, transaction);

                using (var reader = command.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        Console.WriteLine($"{reader.GetString(0), -26}, {reader.GetString(1), -51}, {reader.GetString(2)}");
                    }
                }

                transaction.Commit();
                Console.WriteLine("OK: Application has successfully fetched data out of the database");
            }
            catch(Exception e)
            {
                Console.WriteLine($"NOTOK: Application has encountered an error: {e.Message}\n{e.StackTrace}");

                if(transaction != null)
                {
                    transaction.Rollback();
                }

                throw;
            }
            finally
            {
                if(command != null)
                {
                    command.Dispose();
                }

                if(transaction != null)
                {
                    transaction.Dispose();
                }

                if(connection != null)
                {
                    connection.Close();
                    connection.Dispose();
                }
            }
        }
    }
}
