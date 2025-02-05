using System.ComponentModel.DataAnnotations;

namespace ProjectDunyam.ViewModels
{
    public class Portfolio
    {
        [Key]
        public int Id { get; set; }

        [StringLength(15)]
        public string? Tag { get; set; }

        [StringLength(25)]
        public string? Title { get; set; }

        [StringLength(50)]
        public string? CoverImgUrl { get; set; }

        public bool DeleteId { get; set; }
    }
}
