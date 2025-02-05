using System.ComponentModel.DataAnnotations;

namespace ProjectDunyam.ViewModels
{
    public class AdminUser
    {
        [Key]
        [StringLength(5)]
        public string UserId { get; set; } = null!;

        [Required]
        [StringLength(25)]
        public string NickName { get; set; } = null!;

        [Required]
        [StringLength(100)]
        public string Email { get; set; } = null!;

        [Required]
        [StringLength(20)]
        public string Password { get; set; } = null!;

    }
}
