using Gtk;

namespace DungeonJournal
{
    [GtkTemplate (ui = "/io/github/trytonvanmeer/DungeonJournal/ui/CharacterItemRow.ui")]
    public class CharacterItemRow : ListBoxRow
    {
        [GtkChild] protected Entry name_entry;
        [GtkChild] protected Entry cost_entry;
        [GtkChild] protected SpinButton weight_spinbutton;
        [GtkChild] protected Adjustment weight_adjustment;
        [GtkChild] protected TextView description_entry;

        public CharacterItem item { get; set; }

        public CharacterItemRow(ref CharacterItem item)
        {
            Object();
            this.connect_signals();

            this.item = item;

            this.item.bind_property("item_name", this.name_entry, "text", Util.BINDING_FLAGS);
            this.item.bind_property("cost", this.cost_entry, "text", Util.BINDING_FLAGS);
            this.item.bind_property("weight", this.weight_adjustment, "value", Util.BINDING_FLAGS);
            this.item.bind_property("description", this.description_entry.buffer, "text", Util.BINDING_FLAGS);
        }

        private void connect_signals()
        {
            this.weight_spinbutton.scroll_event.connect(() => {
                Signal.stop_emission_by_name(this.weight_spinbutton, "scroll-event");
                return false;
            });
        }
    }
}