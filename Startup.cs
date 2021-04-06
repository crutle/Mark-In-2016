using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(Mark_In_Admin.Startup))]
namespace Mark_In_Admin
{
    public partial class Startup {
        public void Configuration(IAppBuilder app) {
            ConfigureAuth(app);
        }
    }
}
