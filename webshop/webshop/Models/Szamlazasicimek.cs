﻿using System;
using System.Collections.Generic;

namespace webshop.Models;

public partial class Szamlazasicimek
{
    public int Id { get; set; }

    public string Orszag { get; set; } = null!;

    public string Varos { get; set; } = null!;

    public string Utca { get; set; } = null!;

    public int Hazszam { get; set; }

    public int Iranyitoszam { get; set; }

    public virtual ICollection<User> Users { get; set; } = new List<User>();
}
