using System.Collections.Generic;
using System.Threading.Tasks;
using EasyPay.Model.Dto;

namespace EasyPay.Service.Interface
{
    public interface IBasketService
    {
        Task<BasketItem> AddItemintoBasketAsync(BasketItem basketItem);
        Task<IList<BasketItem>> ChangeBasketItemQuantityAsync(int id, int quantity);
        Task<IList<BasketItem>> ClearBasketAsync(int userId);
        Task<IList<BasketItem>> DeleteBasketItemByIdAsync(int id);
        Task<IList<BasketItem>> GetBasketItemsAsync(int userId);
    }
}