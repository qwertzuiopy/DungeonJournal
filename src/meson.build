deps = [
  math,
  gio,
  glib,
  glib_json,
  gtk,
  gee,
  libadwaita,
]

sources = [
  'Application.vala',
  'Util.vala',
  'Settings.vala',
  'CharacterSheet.vala',
  'CharacterFeat.vala',
  'CharacterAttack.vala',
  'CharacterItem.vala',
  'ui/ApplicationWindow.vala',
  'ui/StartupPage.vala',
  'ui/ShortcutsWindow.vala',
  'ui/CharacterInfoPage.vala',
  'ui/CharacterSkillsPage.vala',
  'ui/CharacterInventoryPage.vala',
  'ui/EntryRow.vala',
  'ui/ComboBoxRow.vala',
  'ui/CharacterSkillRow.vala',
  'ui/SeparatorRow.vala',
  'ui/RecentsCharacterRow.vala',
  'ui/CharacterRowInterface.vala',
  'ui/CharacterFeatRow.vala',
  'ui/CharacterAttackRow.vala',
  'ui/CharacterItemRow.vala',
  'ui/ColumnLayout.vala',
]

c_args = [
  '-include', 'config.h',
  '-DHANDY_USE_UNSTABLE_API',
  '-DLOCALEDIR="@0@"'.format(locale_dir),
]

executable(
    meson.project_name(),
    sources + resources,
    include_directories: config_h_dir,
    dependencies: deps,
    c_args: c_args,
    install: true,
)
