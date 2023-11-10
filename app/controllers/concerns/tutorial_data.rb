module TutorialData
  extend ActiveSupport::Concern

  DATA = { '0' => { title: 'Welcome to', up_text: '', middle_image: 'logo', down_text: '', button: 'Begin' },
           '1' => { title: 'Presentation', up_text: 'Zelda Arena is a Zelda-themed combat simulator', middle_image: '',
                    down_text: '', button: 'Next' },
           '2' => { title: 'Character 1', up_text: 'On your left, you have the character panel.', middle_image: '',
                    down_text: 'You can find iconic characters from the license, but you can also create your own.', button: 'Next' },
           '3' => { title: 'Character 2', up_text: 'Each character has 4 main characteristics.',
                    middle_image: 'character_2', down_text: 'An average character has a 35-point spread over these four characteristics', button: 'Next' },
           '4' => { title: 'Character 3', up_text: 'They also have 4 hidden characteristics to make combat more interesting.',
                    middle_image: 'character_3', down_text: 'A random feature is automatically enhanced with each level', button: 'Next' },
           '5' => { title: 'Equipment 1', up_text: 'Below you have the equipment panel.', middle_image: '',
                    down_text: "You'll find iconic weapons and shields from the license", button: 'Next' },
           '6' => { title: 'Equipment 2',
                    up_text: 'Each weapon has a position attribute corresponding to the hand in which it is used.', middle_image: 'equipment_2', down_text: 'Shields are carried in the left hand, swords in the right.', button: 'Next' },
           '7' => { title: 'Equipment 3',
                    up_text: 'Each equipment influences two characteristics (main or secondary) if equipped.', middle_image: '', down_text: 'You can see its effects by hovering over the equipment.', button: 'Next' },
           '8' => { title: 'Battles', up_text: 'On your right, you have the battle history panel', middle_image: '',
                    down_text: 'You can retrieve the ten last battle finished.', button: 'Next' },
           '9' => { title: 'Arena 1', up_text: 'At the top center is the arena battle', middle_image: '',
                    down_text: 'This is where all the action takes place', button: 'Next' },
           '10' => { title: 'Arena 2',
                     up_text: 'To start a fight, simply drag characters and equipment into the corresponding slots.', middle_image: 'arena_2', down_text: 'The minimum requirement is two people without equipment!', button: 'Next' },
           '11' => { title: 'Arena 3', up_text: "Once the fight is over, you'll find a summary of each character.",
                     middle_image: 'arena_3', down_text: '', button: 'Next' },
           '12' => { title: 'Enjoy', up_text: "You're ready to launch your first fight!", middle_image: '', down_text: 'Have fun with Zelda Arena!',
                     button: "Let's Battle !" } }.freeze

  def retrieve_data(page)
    DATA[page.to_s]
  end
end
