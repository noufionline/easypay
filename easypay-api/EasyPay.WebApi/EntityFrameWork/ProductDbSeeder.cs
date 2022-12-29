using EasyPay.Model.Dto;
using EasyPay.Model.EntityFrameWork;
using Microsoft.EntityFrameworkCore;

namespace EasyPay.WebApi.EntityFrameWork
{
    public class ProductDbSeeder
    {
        readonly ILogger _logger;

        public ProductDbSeeder(ILoggerFactory loggerFactory)
        {
            _logger = loggerFactory.CreateLogger("ProductDataSeederLogger");
        }

        public async Task SeedAsync(IServiceProvider serviceProvider)
        {
            //Based on EF team's example at https://github.com/aspnet/MusicStore/blob/dev/samples/MusicStore/Models/SampleData.cs
            using (var serviceScope = serviceProvider.GetRequiredService<IServiceScopeFactory>().CreateScope())
            {
                var db = serviceScope.ServiceProvider.GetService<EasyPayDbContext>();
                if (await db.Database.EnsureCreatedAsync())
                {
                    if (!await db.Products.AnyAsync())
                    {
                        await AddTestData(db);
                    }
                }
            }
        }

        private static async Task AddTestData(EasyPayDbContext context)
        {
            IList<Product> products = new List<Product>();
            products.Add(new Product { Id = 1, Name = "Water Glass", Price = 10.00M, Photo = "", Desciption = "Water Glass for drinking" });
            products.Add(new Product { Id = 2, Name = "Jug Water Glass", Price = 12.00M, Photo = "", Desciption = "Water Glass for drinking" });
            products.Add(new Product { Id = 3, Name = "Green Water Glass", Price = 13.00M, Photo = "", Desciption = "Water Glass for drinking" });
            products.Add(new Product { Id = 4, Name = "Red Water Glass", Price = 14.00M, Photo = "", Desciption = "Water Glass for drinking" });
            products.Add(new Product { Id = 5, Name = "Yellow Water Glass", Price = 15.00M, Photo = "", Desciption = "Water Glass for drinking" });
            context.Products.AddRange(products);

            IList<BasketItem> basketItems = new List<BasketItem>();
            basketItems.Add(new BasketItem { Id = 1, ProductId = 1, Quantity = 2, UserId = 1 });
            basketItems.Add(new BasketItem { Id = 2, ProductId = 5, Quantity = 1, UserId = 1 });
            context.BasketItems.AddRange(basketItems);

           await context.SaveChangesAsync();
        }
   

    }
}
