using Gtk;

namespace DungeonJournal
{
    [GtkTemplate (ui = "/io/github/trytonvanmeer/DungeonJournal/ui/StartupWindow.ui")]
    public class StartupWindow : Window
    {
        private DungeonJournal.ApplicationWindow window;

        private bool done_startup { get; set; default=false; }

        public StartupWindow(DungeonJournal.ApplicationWindow window)
        {
            Object();
            this.window = window;
        }

        [GtkCallback]
        private void on_destroy()
        {
            if (!this.done_startup)
            {
                this.window.destroy();
            }
        }
    }
}