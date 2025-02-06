using System;
using System.Collections.Generic;

namespace webshop.Models;

public partial class Felhasznalok
{
    public int Id { get; set; }

    public string LoginName { get; set; } = null!;

    public string Email { get; set; } = null!;

    public int? SzamlazasiCimId { get; set; }

    public string Salt { get; set; } = null!;

    public string Hash { get; set; } = null!;

    public virtual ICollection<Rendelesek> Rendeleseks { get; set; } = new List<Rendelesek>();

    public virtual Szamlazasicimek? SzamlazasiCim { get; set; }
}
