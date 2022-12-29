using EasyPay.Model.Dto;
using System.Collections.Generic;
using System.Threading.Tasks;

namespace EasyPay.Service.Interface
{
    public interface IProductService
    {
        Task<IList<Product>> GetProductsAsync();
        Task<Product> GetProductAsync(int productId);
    }
}
