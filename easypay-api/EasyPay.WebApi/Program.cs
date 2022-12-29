using EasyPay.Model.GenericRepository.Implementation;
using EasyPay.Model.GenericRepository.Repository;
using EasyPay.Service.Interface;
using EasyPay.Service.Service;
using EasyPay.Model.EntityFrameWork;
using Microsoft.EntityFrameworkCore;
using System.Configuration;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.Hosting;
using EasyPay.WebApi.EntityFrameWork;

var builder = WebApplication.CreateBuilder(args);

// Add services to the container.

builder.Services.AddControllers();


builder.Services.AddDbContext<EasyPayDbContext>(options =>
options
                    .UseNpgsql(builder.Configuration.GetConnectionString("EasyPayContext"))
                    .UseSnakeCaseNamingConvention()
                    .UseLoggerFactory(LoggerFactory.Create(builder => builder.AddConsole()))
                    .EnableSensitiveDataLogging()
            );

builder.Services.AddScoped<IProductService, ProductService>();
builder.Services.AddScoped<IBasketService, BasketService>();
builder.Services.AddScoped<IRepository, EntityFrameworkRepository>();
builder.Services.AddScoped<IRepositoryReadOnly, EntityFrameworkRepositoryReadOnly>();
//builder.Services.AddTransient<ProductDbSeeder>();

// Learn more about configuring Swagger/OpenAPI at https://aka.ms/aspnetcore/swashbuckle
builder.Services.AddEndpointsApiExplorer();
builder.Services.AddSwaggerGen();
var app = builder.Build();

using (var scope = app.Services.CreateScope())
{
    var db = scope.ServiceProvider.GetRequiredService<EasyPayDbContext>();
    if(db!=null)
        try
        {
            await db.Database.EnsureCreatedAsync();
        }
        catch
        {

        }
    
}



//// Configure the HTTP request pipeline.
//if (app.Environment.IsDevelopment())
//{
    app.UseSwagger();
    app.UseSwaggerUI();
//}

app.UseHttpsRedirection();

app.UseAuthorization();

app.MapControllers();

app.Run();
