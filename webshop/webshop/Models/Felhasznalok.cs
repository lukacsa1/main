using System;
using System.Collections.Generic;

namespace webshop.Models;

public partial class Felhasznalok
{
    public int Id { get; set; }

    public string LoginNev { get; set; } = null!;

    public string Jelszo { get; set; } = null!;

    public string Email { get; set; } = null!;

    public int? SzamlazasiCimId { get; set; }

    public virtual ICollection<Rendelesek> Rendeleseks { get; set; } = new List<Rendelesek>();

    public virtual Szamlazasicimek? SzamlazasiCim { get; set; }
}
