using Microsoft.EntityFrameworkCore;
using System;
using System.Collections.Generic;
using System.Text;

namespace EasyPay.Model.Dto
{  
    public class Product
    {
        public Product()
        {
            BasketItems =new HashSet<BasketItem>();
        }
        public int Id { get; set; }
        public string Name { get; set; }
        public string Desciption { get; set; }
        public decimal Price { get; set; }
        public string Photo { get; set; }

        public virtual ICollection<BasketItem> BasketItems{get;set;}
    }
}
