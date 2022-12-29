using EasyPay.Service.Interface;
using EasyPay.Model.Dto;
using EasyPay.Model.EntityFrameWork;
using EasyPay.Model.GenericRepository.Repository;
using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace EasyPay.Service.Service
{
    public class BasketService : IBasketService
    {
        private readonly IRepository _iRepository;
        public BasketService(IRepository iRepository)
        {
            _iRepository = iRepository;
        }

        public async Task<BasketItem> AddItemintoBasketAsync(BasketItem basketItem)
        {
            IEnumerable<BasketItem> basketItems = await _iRepository.GetAsync<BasketItem>(b => b.UserId == basketItem.UserId);
           
            _iRepository.Create<BasketItem>(basketItem);
            await _iRepository.SaveAsync();
            return basketItem;
        }

        public async Task<IList<BasketItem>> GetBasketItemsAsync(int userId)
        {
            var basketItems = await _iRepository.GetAsync<BasketItem>(b => b.UserId == userId);
            return basketItems.ToList();
        }

        public async Task<IList<BasketItem>> ClearBasketAsync(int userId)
        {
            var basketItems = await _iRepository.GetAsync<BasketItem>(b => b.UserId == userId);

            foreach (var basketItem in basketItems)
            {
                _iRepository.Delete<BasketItem>(basketItem);
            }
            await _iRepository.SaveAsync();

            return await GetBasketItemsAsync(userId);
        }

        public async Task<IList<BasketItem>> DeleteBasketItemByIdAsync(int id)
        {
            var basketItem = await _iRepository.GetByIdAsync<BasketItem>(id);
            if (basketItem != null)
            {
                _iRepository.Delete<BasketItem>(basketItem);
                await _iRepository.SaveAsync();
            }

            return await GetBasketItemsAsync(basketItem.UserId);
        }

        public async Task<IList<BasketItem>> ChangeBasketItemQuantityAsync(int id, int quantity)
        {
            var basketItem = await _iRepository.GetByIdAsync<BasketItem>(id);

            if (basketItem == null)
                return null;

            basketItem.Quantity = quantity;

            _iRepository.Update<BasketItem>(basketItem);
            await _iRepository.SaveAsync();
            return await GetBasketItemsAsync(basketItem.UserId);
        }

    }
}
