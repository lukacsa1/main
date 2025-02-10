﻿using System.Security.Cryptography;
using System.Text;
using webshop.Models;

namespace webshop
{
    public class Manager
    {
        public static int SaltLength = 64;
        public static Dictionary<string, User> LoggedInUsers = new Dictionary<string, User>();
        public static string UserNotEligableMessage = "Nem megfelelő jogkör!";
        public static string GenerateSalt()
        {
            Random random = new Random();
            string karakterek = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
            string salt = "";
            for (int i = 0; i < SaltLength; i++)
            {
                salt += karakterek[random.Next(karakterek.Length)];
            }
            return salt;
        }
        public static string CreateSHA256(string input)
        {
            using (SHA256 sha256 = SHA256.Create())
            {
                byte[] data = sha256.ComputeHash(Encoding.UTF8.GetBytes(input));
                var sBuilder = new StringBuilder();
                for (int i = 0; i < data.Length; i++)
                {
                    sBuilder.Append(data[i].ToString("x2"));
                }
                return sBuilder.ToString();
            }
        }

        public static bool CheckPermission(string token, int requiredPermissionLevel)
        {
            if(LoggedInUsers.ContainsKey(token) && LoggedInUsers[token].PermissionLevel >= requiredPermissionLevel)
                return true;
            else
                return false;
        }
    }
}
