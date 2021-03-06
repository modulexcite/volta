using System;
using Volta.Core.Infrastructure.Framework.Security;

namespace Volta.Core.Domain.Administration
{
    public class User
    {
        private Username _username;

        public Guid Id { get; set; }
        public string Username { get { return _username; } set { _username = value; } }
        public string PasswordHash { get; set; }
        public string Email { get; set; }
        public bool Administrator { get; set; }
        public DateTime Created { get; set; }
        public string CreatedBy { get; set; }

        public void SetPassword(string password)
        {
            PasswordHash = HashedPassword.Create(password).ToString();
        }
    }
}