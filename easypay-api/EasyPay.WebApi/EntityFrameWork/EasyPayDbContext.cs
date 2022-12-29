using EasyPay.Model.Dto;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace EasyPay.Model.EntityFrameWork
{
    public partial class EasyPayDbContext : DbContext
    {
        public EasyPayDbContext(DbContextOptions<EasyPayDbContext> options)
           : base(options)
        {
        }

        public virtual DbSet<Product> Products { get; set; }

        public virtual DbSet<BasketItem> BasketItems { get; set; }


        protected override void OnModelCreating(ModelBuilder modelBuilder)
        {
        
            modelBuilder.Entity<Product>().HasKey(x=> x.Id);
            modelBuilder.Entity<Product>().HasMany(x => x.BasketItems).WithOne(x=> x.Product).HasForeignKey(x=> x.ProductId);

            modelBuilder.Entity<BasketItem>().HasKey(x=> x.Id);


            IList<Product> products = new List<Product>();
            products.Add(new Product { Id = 1, Name = "Water Glass", Price = 10.00M, Photo = "", Desciption = "Water Glass for drinking" });
            products.Add(new Product { Id = 2, Name = "Jug Water Glass", Price = 12.00M, Photo = "", Desciption = "Water Glass for drinking" });
            products.Add(new Product { Id = 3, Name = "Green Water Glass", Price = 13.00M, Photo = "", Desciption = "Water Glass for drinking" });
            products.Add(new Product { Id = 4, Name = "Red Water Glass", Price = 14.00M, Photo = "", Desciption = "Water Glass for drinking" });
            products.Add(new Product { Id = 5, Name = "Yellow Water Glass", Price = 15.00M, Photo = "", Desciption = "Water Glass for drinking" });

            modelBuilder.Entity<Product>().HasData(products);

            IList<BasketItem> basketItems = new List<BasketItem>();
            basketItems.Add(new BasketItem { Id = 1, ProductId = 1, Quantity = 2, UserId = 1 });
            basketItems.Add(new BasketItem { Id = 2, ProductId = 5, Quantity = 1, UserId = 1 });
            modelBuilder.Entity<BasketItem>().HasData(basketItems);
        }


    }
}
