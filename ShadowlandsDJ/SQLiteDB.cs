using System;
using System.Collections.Generic;
using System.Data.SQLite;
using System.Linq;
using System.Text;

namespace WindowsFormsApplication1
{
    ///<summary>Class to manage access to the database that will contain all DJ data.</summary>
    class SQLiteDB
    {
        String db_connection_string;
        SQLiteConnection db_connection;
        SQLiteCommand check_tables;
        SQLiteDataReader read_tables;

        /// <summary>
        /// Default constructor for the SQLite database.
        /// </summary>
        public SQLiteDB()
        {
            db_connection_string = "Data Source = Shadowlands.dj";
            db_connection = new SQLiteConnection(db_connection_string);
            db_connection.Open();
            check_tables = db_connection.CreateCommand();
            CheckDBStructure();
        }

        /// <summary>
        /// Constructor allowing user to specify their own db name.
        /// </summary>
        /// <param name="dbname">Name of the database to be created, to allow for the management of multiple DJs.</param>
        public SQLiteDB(String dbname = "Shadowlands")
        {
            int index_of_invalid_char = dbname.IndexOfAny(System.IO.Path.GetInvalidFileNameChars());
            while (index_of_invalid_char >= 0)
                dbname.Remove(index_of_invalid_char, 1);
            db_connection_string = "Data Source = " + dbname + ".dj";
            db_connection = new SQLiteConnection(db_connection_string);
            db_connection.Open();
            check_tables = db_connection.CreateCommand();
            CheckDBStructure();
        }

        ///<summary>
        ///Checks the database for all program tables and adds any that don't exist.
        ///</summary>
        ///<returns>Returns false in case of failure, else true.</returns>
        public bool CheckDBStructure()
        {
            //Dreams Table
            check_tables.CommandText = "SELECT name FROM sqlite_master WHERE name = 'Dreams'";
            read_tables = check_tables.ExecuteReader();
            if (read_tables.IsDBNull(0))
            {
                read_tables.Close();
                check_tables.CommandText = "CREATE TABLE Dreams(Key int Primary Key, Title text, Date text, Clarity int, Lucidity int, Rating int, PreSleepNotes text, Dream text, PostSleepNotes text)";
                check_tables.ExecuteNonQuery();
            }
            else
            {
                read_tables.Close();
            }
            return true;
        }
    }
}
