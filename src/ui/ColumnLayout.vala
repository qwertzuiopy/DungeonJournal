using Gtk;
using Gee;

namespace DungeonJournal
{

    class ColumnLayout : Gtk.LayoutManager {
        public int spacing = 20;

        public ColumnLayout() {
            Object();
        }

       protected override void measure (Gtk.Widget widget,
                                     Gtk.Orientation orientation,
                                     int for_size,
                                     out int minimum,
                                     out int natural,
                                     out int minimum_baseline,
                                     out int natural_baseline) {

            if (orientation == Gtk.Orientation.HORIZONTAL) {
                minimum = for_size;
                natural = for_size;
                minimum_baseline = -1;
                natural_baseline = -1;
                return;
            }

            int child_natural_width = 0;
            for (Gtk.Widget child = widget.get_first_child(); child != null; child = child.get_next_sibling()) {
                int child_min = 0;
                int child_nat = 0;
                child.measure (Gtk.Orientation.HORIZONTAL, -1, out child_min, out child_nat, null, null);
                child_natural_width = int.max(child_natural_width, child_nat);
            }

            if (child_natural_width == 0) {
                minimum = 0;
                natural = 0;
                minimum_baseline = -1;
                natural_baseline = -1;
                return;
            }

            int column_count = int.max((int) (for_size / (child_natural_width + this.spacing)), 1);

            ArrayList<int> columns = new ArrayList<int>();
            for (int i = 0; i < column_count; i++) {
                columns.add(0);
            }

            for (Gtk.Widget child = widget.get_first_child(); child != null; child = child.get_next_sibling()) {
                int child_min = 0;
                int child_nat = 0;
                child.measure (Gtk.Orientation.VERTICAL, -1, out child_min, out child_nat, null, null);
                int min = 0;
                for (int i = 0; i < column_count; i++) {
                    if (columns[i] < columns[min]) {
                        min = i;
                    }
                }
                columns[min] += child_nat + spacing;
            }

            int max = 0;
            for (int i = 0; i < column_count; i++) {
                if (columns[i] > columns[max]) {
                        max = i;
                }
            }

            minimum = columns[max];
            natural = columns[max];
            minimum_baseline = -1;
            natural_baseline = -1;
        }

        protected override void allocate (Gtk.Widget widget, int width, int height, int baseline) {
            int child_width = 0;
            for (Gtk.Widget child = widget.get_first_child(); child != null; child = child.get_next_sibling()) {
                Gtk.Requisition child_req;
                child.get_preferred_size (out child_req, null);
                child_width = int.max(child_width, child_req.width);
            }

            if (child_width == 0) {
                return;
            }

            int column_count = int.max((int) (width / (child_width + this.spacing)), 1);

            int column_width = width / column_count - this.spacing * column_count;
            if (column_count == 1) {
                column_width = int.min(width - this.spacing * 2, child_width);
            }

            int content_width = (column_width + this.spacing) * column_count;
            int offset = (width - content_width) / 2 + this.spacing / 2;

            ArrayList<int> columns = new ArrayList<int>();
            for (int i = 0; i < column_count; i++) {
                columns.add(0);
            }

            for (Gtk.Widget child = widget.get_first_child(); child != null; child = child.get_next_sibling()) {
                Gtk.Requisition child_req;
                child.get_preferred_size (out child_req, null);

                int min = 0;
                for (int i = 0; i < column_count; i++) {
                    if (columns[i] < columns[min]) {
                        min = i;
                    }
                }

                child.allocate_size ({ offset + content_width / column_count * min, columns[min], column_width, child_req.height }, -1);
                columns[min] += child_req.height + spacing;
            }
        }

        protected override Gtk.SizeRequestMode get_request_mode (Gtk.Widget widget) {
           return Gtk.SizeRequestMode.HEIGHT_FOR_WIDTH;
        }

    }

    class ColumnWidget : Gtk.Box {
        public ColumnWidget() {
            Object();
            this.layout_manager = new ColumnLayout();
        }
    }
}
