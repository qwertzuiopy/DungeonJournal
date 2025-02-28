using Gtk;
using Gee;

namespace DungeonJournal
{
    [GtkTemplate (ui = "/io/github/trytonvanmeer/DungeonJournal/ui/CharacterSkillsPage.ui")]
    public class CharacterSkillsPage : Box
    {
        [GtkChild] protected unowned Box column_widget;

        [GtkChild] protected unowned ListBox strength_listbox;
        [GtkChild] protected unowned ListBox dexterity_listbox;
        [GtkChild] protected unowned ListBox constitution_listbox;
        [GtkChild] protected unowned ListBox intelligence_listbox;
        [GtkChild] protected unowned ListBox wisdom_listbox;
        [GtkChild] protected unowned ListBox charisma_listbox;

        protected Adw.SpinRow strength_score;
        protected CharacterSkillRow strength_save;

        protected Adw.SpinRow dexterity_score;
        protected CharacterSkillRow dexterity_save;

        protected Adw.SpinRow constitution_score;
        protected CharacterSkillRow constitution_save;

        protected Adw.SpinRow intelligence_score;
        protected CharacterSkillRow intelligence_save;

        protected Adw.SpinRow wisdom_score;
        protected CharacterSkillRow wisdom_save;

        protected Adw.SpinRow charisma_score;
        protected CharacterSkillRow charisma_save;

        protected HashMap<Ability, ListBox> abilities;
        protected ArrayList<CharacterSkillRow> skills;

        public CharacterSkillsPage()
        {
            Object();

            this.column_widget.layout_manager = new ColumnLayout();

            this.abilities = new HashMap<Ability, ListBox>();

            this.abilities.set(Ability.STRENGTH, this.strength_listbox);
            this.abilities.set(Ability.DEXTERITY, this.dexterity_listbox);
            this.abilities.set(Ability.CONSTITUTION, this.constitution_listbox);
            this.abilities.set(Ability.INTELLIGENCE, this.intelligence_listbox);
            this.abilities.set(Ability.WISDOM, this.wisdom_listbox);
            this.abilities.set(Ability.CHARISMA, this.charisma_listbox);

            this.skills = new ArrayList<CharacterSkillRow>();

            this.setup_view();
        }

        private void setup_view()
        {
            this.setup_view_abilities();
            this.setup_view_skills();
        }

        private Adw.SpinRow spin_row_with_ability_score_label()
        {
            var row = new Adw.SpinRow(new Gtk.Adjustment(0, 0, 100, 1, 5, 10), 1, 0);
            
            row.title = _("Score");
            set_subtitle_to_modifier(row);
            
            row.adjustment.value_changed.connect(() => {
                    set_subtitle_to_modifier(row);
                });
            
            return row;
        }

        private void set_subtitle_to_modifier(Adw.SpinRow row)
        {
            var modifier = Util.calculate_ability_modifier(row.adjustment.value);
            row.subtitle = modifier;
        }

        private void setup_view_abilities()
        {
            this.strength_score = spin_row_with_ability_score_label();
            this.strength_save = new CharacterSkillRow(_("Saving Throws"));

            this.strength_listbox.append(this.strength_score);
            this.strength_listbox.append(this.strength_save.skill_row);

            this.dexterity_score = spin_row_with_ability_score_label();
            this.dexterity_save = new CharacterSkillRow(_("Saving Throws"));

            this.dexterity_listbox.append(this.dexterity_score);
            this.dexterity_listbox.append(this.dexterity_save.skill_row);

            this.constitution_score = spin_row_with_ability_score_label();
            this.constitution_save = new CharacterSkillRow(_("Saving Throws"));

            this.constitution_listbox.append(this.constitution_score);
            this.constitution_listbox.append(this.constitution_save.skill_row);

            this.intelligence_score = spin_row_with_ability_score_label();
            this.intelligence_save = new CharacterSkillRow(_("Saving Throws"));

            this.intelligence_listbox.append(this.intelligence_score);
            this.intelligence_listbox.append(this.intelligence_save.skill_row);

            this.wisdom_score = spin_row_with_ability_score_label();
            this.wisdom_save = new CharacterSkillRow(_("Saving Throws"));

            this.wisdom_listbox.append(this.wisdom_score);
            this.wisdom_listbox.append(this.wisdom_save.skill_row);

            this.charisma_score = spin_row_with_ability_score_label();
            this.charisma_save = new CharacterSkillRow(_("Saving Throws"));

            this.charisma_listbox.append(this.charisma_score);
            this.charisma_listbox.append(this.charisma_save.skill_row);
        }

        private void setup_view_skills()
        {
            // strength
            this.add_skill_row(Ability.STRENGTH, "athletics", _("Athletics"));

            // dexterity
            this.add_skill_row(Ability.DEXTERITY, "acrobatics", _("Acrobatics"));
            this.add_skill_row(Ability.DEXTERITY, "sleight_of_hand", _("Sleight of Hand"));
            this.add_skill_row(Ability.DEXTERITY, "stealth", _("Stealth"));

            // intelligence
            this.add_skill_row(Ability.INTELLIGENCE, "arcana", _("Arcana"));
            this.add_skill_row(Ability.INTELLIGENCE, "history", _("History"));
            this.add_skill_row(Ability.INTELLIGENCE, "investigation", _("Investigation"));
            this.add_skill_row(Ability.INTELLIGENCE, "nature", _("Nature"));
            this.add_skill_row(Ability.INTELLIGENCE, "religion", _("Religion"));

            // wisdom
            this.add_skill_row(Ability.WISDOM, "animal_handling", _("Animal Handling"));
            this.add_skill_row(Ability.WISDOM, "insight", _("Insight"));
            this.add_skill_row(Ability.WISDOM, "medicine", _("Medicine"));
            this.add_skill_row(Ability.WISDOM, "perception", _("Perception"));
            this.add_skill_row(Ability.WISDOM, "survival", _("Survival"));

            // charisma
            this.add_skill_row(Ability.CHARISMA, "deception", _("Deception"));
            this.add_skill_row(Ability.CHARISMA, "intimidation", _("Intimidation"));
            this.add_skill_row(Ability.CHARISMA, "performance", _("Performance"));
            this.add_skill_row(Ability.CHARISMA, "persuasion", _("Persuasion"));
        }

        private void add_skill_row(Ability ability, string skill, string label)
        {
            var skill_row = new CharacterSkillRow(label);
            skill_row.skill_row.set_name(skill);

            this.abilities.get(ability).append(skill_row.skill_row);
            this.skills.add(skill_row);
        }

        public void bind_character(CharacterSheet character)
        {
            character.bind("strength_score", this.strength_score, "value");
            character.bind("strength_save_proficiency", this.strength_save, "proficient");
            character.bind("strength_save", this.strength_save, "value");

            character.bind("dexterity_score", this.dexterity_score, "value");
            character.bind("dexterity_save_proficiency", this.dexterity_save, "proficient");
            character.bind("dexterity_save", this.dexterity_save, "value");

            character.bind("constitution_score", this.constitution_score, "value");
            character.bind("constitution_save_proficiency", this.constitution_save, "proficient");
            character.bind("constitution_save", this.constitution_save, "value");

            character.bind("intelligence_score", this.intelligence_score, "value");
            character.bind("intelligence_save_proficiency", this.intelligence_save, "proficient");
            character.bind("intelligence_save", this.intelligence_save, "value");

            character.bind("wisdom_score", this.wisdom_score, "value");
            character.bind("wisdom_save_proficiency", this.wisdom_save, "proficient");
            character.bind("wisdom_save", this.wisdom_save, "value");

            character.bind("charisma_score", this.charisma_score, "value");
            character.bind("charisma_save_proficiency", this.charisma_save, "proficient");
            character.bind("charisma_save", this.charisma_save, "value");

            foreach (CharacterSkillRow row in this.skills)
            {
                var name = row.skill_row.get_name();

                character.bind(@"$(name)_skill_proficiency", row, "proficient");
                character.bind(@"$(name)_skill", row, "value");
            }
        }
    }
}
