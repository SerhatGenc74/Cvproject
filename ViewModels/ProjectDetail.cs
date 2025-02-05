using System.ComponentModel.DataAnnotations.Schema;
using System.ComponentModel.DataAnnotations;

namespace ProjectDunyam.ViewModels
{
    public class ProjectDetail
    {
        public int Id { get; set; }

        [ForeignKey("Project")]
        [StringLength(4)]
        public string ProjectId { get; set; } = null!;

        [Required]
        [StringLength(20)]
        public string Type { get; set; } = null!;

        [StringLength(20)]
        public string? VisibleContent { get; set; }

        [StringLength(10)]
        public string? Content { get; set; }

        public bool DeleteId { get; set; }

        public Project Project { get; set; } = null!;
    }
}
