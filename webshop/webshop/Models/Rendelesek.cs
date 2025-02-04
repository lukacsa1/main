using System;
using System.Collections.Generic;

namespace webshop.Models;

public partial class Rendelesek
{
    public int RendelesSzam { get; set; }

    public string Statusz { get; set; } = null!;

    public int? FelhasznaloId { get; set; }

    public virtual Felhasznalok? Felhasznalo { get; set; }
}
