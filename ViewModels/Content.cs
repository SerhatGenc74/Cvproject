using System.ComponentModel.DataAnnotations;

namespace ProjectDunyam.ViewModels
{
    public class Content
    {
        [Key]
        [StringLength(10)]
        public string ContentId { get; set; } = null!;

        [Required]
        [StringLength(20)]
        public string Type { get; set; } = null!; // Paragraf

        [StringLength(50)]
        public string? Tags { get; set; }

        [StringLength(20)]
        public string? VisibleContent { get; set; }

        [StringLength(20)]
        public string? ContentText { get; set; }

        [StringLength(20)]
        public string? SubContent { get; set; }

        public bool DeleteId { get; set; }
    }
}
