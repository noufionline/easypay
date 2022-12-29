using System;
using System.Collections.Generic;
using System.Text;

namespace EasyPay.Model.Dto
{
    public class BasketItem
    {
        public int Id { get; set; }
        public int ProductId { get; set; }
        public virtual Product Product { get; set; }
        public int Quantity { get; set; }
        public int UserId { get; set; }
    }
}
