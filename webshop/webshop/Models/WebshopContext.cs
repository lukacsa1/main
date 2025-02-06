using System;
using System.Collections.Generic;
using Microsoft.EntityFrameworkCore;

namespace webshop.Models;

public partial class WebshopContext : DbContext
{
    public WebshopContext()
    {
    }

    public WebshopContext(DbContextOptions<WebshopContext> options)
        : base(options)
    {
    }

    public virtual DbSet<Felhasznalok> Felhasznaloks { get; set; }

    public virtual DbSet<Rendelesek> Rendeleseks { get; set; }

    public virtual DbSet<Szamlazasicimek> Szamlazasicimeks { get; set; }

    public virtual DbSet<Termekek> Termekeks { get; set; }

    protected override void OnConfiguring(DbContextOptionsBuilder optionsBuilder)
#warning To protect potentially sensitive information in your connection string, you should move it out of source code. You can avoid scaffolding the connection string by using the Name= syntax to read it from configuration - see https://go.microsoft.com/fwlink/?linkid=2131148. For more guidance on storing connection strings, see https://go.microsoft.com/fwlink/?LinkId=723263.
        => optionsBuilder.UseMySQL("SERVER=localhost;PORT=3306;DATABASE=webshop;USER=root;PASSWORD=;SSL MODE=none;");

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<Felhasznalok>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("felhasznalok");

            entity.HasIndex(e => e.LoginName, "LoginNev");

            entity.HasIndex(e => e.SzamlazasiCimId, "fk_szamlazasiCim");

            entity.Property(e => e.Id).HasColumnType("int(32)");
            entity.Property(e => e.Email).HasMaxLength(64);
            entity.Property(e => e.Hash)
                .HasMaxLength(64)
                .HasColumnName("HASH");
            entity.Property(e => e.LoginName).HasMaxLength(32);
            entity.Property(e => e.Salt)
                .HasMaxLength(64)
                .HasColumnName("SALT");
            entity.Property(e => e.SzamlazasiCimId)
                .HasDefaultValueSql("'NULL'")
                .HasColumnType("int(32)")
                .HasColumnName("szamlazasiCimId");

            entity.HasOne(d => d.SzamlazasiCim).WithMany(p => p.Felhasznaloks)
                .HasForeignKey(d => d.SzamlazasiCimId)
                .OnDelete(DeleteBehavior.SetNull)
                .HasConstraintName("fk_szamlazasiCim");
        });

        modelBuilder.Entity<Rendelesek>(entity =>
        {
            entity.HasKey(e => e.RendelesSzam).HasName("PRIMARY");

            entity.ToTable("rendelesek");

            entity.HasIndex(e => e.FelhasznaloId, "fk_felhasznalo");

            entity.Property(e => e.RendelesSzam).HasColumnType("int(32)");
            entity.Property(e => e.FelhasznaloId)
                .HasDefaultValueSql("'NULL'")
                .HasColumnType("int(32)")
                .HasColumnName("felhasznaloId");
            entity.Property(e => e.Statusz).HasMaxLength(32);

            entity.HasOne(d => d.Felhasznalo).WithMany(p => p.Rendeleseks)
                .HasForeignKey(d => d.FelhasznaloId)
                .OnDelete(DeleteBehavior.Cascade)
                .HasConstraintName("fk_felhasznalo");
        });

        modelBuilder.Entity<Szamlazasicimek>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("szamlazasicimek");

            entity.Property(e => e.Id).HasColumnType("int(32)");
            entity.Property(e => e.Hazszam)
                .HasColumnType("int(32)")
                .HasColumnName("hazszam");
            entity.Property(e => e.Iranyitoszam)
                .HasColumnType("int(32)")
                .HasColumnName("iranyitoszam");
            entity.Property(e => e.Orszag).HasMaxLength(32);
            entity.Property(e => e.Utca)
                .HasMaxLength(64)
                .HasColumnName("utca");
            entity.Property(e => e.Varos).HasMaxLength(64);
        });

        modelBuilder.Entity<Termekek>(entity =>
        {
            entity.HasKey(e => e.Id).HasName("PRIMARY");

            entity.ToTable("termekek");

            entity.Property(e => e.Id).HasColumnType("int(32)");
            entity.Property(e => e.Ar)
                .HasColumnType("int(64)")
                .HasColumnName("ar");
            entity.Property(e => e.Kategoria)
                .HasMaxLength(32)
                .HasColumnName("kategoria");
            entity.Property(e => e.Kep)
                .HasMaxLength(32)
                .HasColumnName("kep");
            entity.Property(e => e.Meret)
                .HasMaxLength(64)
                .HasColumnName("meret");
            entity.Property(e => e.TermekNeve).HasMaxLength(64);
        });

        OnModelCreatingPartial(modelBuilder);
    }

    partial void OnModelCreatingPartial(ModelBuilder modelBuilder);
}
