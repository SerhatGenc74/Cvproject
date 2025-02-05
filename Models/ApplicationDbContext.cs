using Microsoft.EntityFrameworkCore;
using ProjectDunyam.ViewModels;

namespace ProjectDunyam.Models
{
    public class ApplicationDbContext : DbContext
    {
        public ApplicationDbContext(DbContextOptions<ApplicationDbContext> options) : base(options) { }
        public DbSet<AdminUser> AdminUsers { get; set; }
        public DbSet<Content> Contents { get; set; }
        public DbSet<Project> Projects { get; set; }
        public DbSet<ProjectDetail> ProjectDetails { get; set; }
        public DbSet<Portfolio> Portfolio { get; set; }
    }
}
