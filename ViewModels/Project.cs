using System.ComponentModel.DataAnnotations;

namespace ProjectDunyam.ViewModels
{
    public class Project
    {
        public int id { get; set; }
        [Key]
        [StringLength(4)]
        public string ProjectId { get; set; } = null!;

        [StringLength(25)]
        public string? Title { get; set; }

        [StringLength(150)]
        public string? Description { get; set; }

        [StringLength(50)]
        public string? CoverImgUrl { get; set; }

        [StringLength(50)]
        public string? Tags { get; set; }

        public bool DeleteId { get; set; }
    }
}
