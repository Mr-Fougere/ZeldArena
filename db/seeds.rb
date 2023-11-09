# frozen_string_literal: true
p 'Character creation ...'

Character.create([{ name: 'Link' },
                  { name: 'Zelda', health_points: 20, speed: 4, attack_power: 1, armor_points: 10 },
                  { name: 'Ganon', health_points: 20, speed: 2, attack_power: 5, armor_points: 20 },
                  { name: 'Vaati', health_points: 30, speed: 3, attack_power: 4, armor_points: 0 },
                  { name: 'Ghirahim', health_points: 15, speed: 4.2, attack_power: 1.5, armor_points: 10 },
                  { name: 'Fi', health_points: 25, speed: 3.5, attack_power: 2, armor_points: 0 }])
p 'Characters created'
p 'Effect creation ...'

Effect.create([{ name: 'Lose HP', affected_stat: 'health_points', affected_type: 'negative' },
               { name: 'Gain HP', affected_stat: 'health_points', affected_type: 'positive' },
               { name: 'Lose Attack', affected_stat: 'attack_power', affected_type: 'negative' },
               { name: 'Gain Attack', affected_stat: 'attack_power', affected_type: 'positive' },
               { name: 'Lose Speed', affected_stat: 'speed', affected_type: 'negative' },
               { name: 'Gain Speed', affected_stat: 'speed', affected_type: 'positive' },
               { name: 'Lose Armor', affected_stat: 'armor_points', affected_type: 'negative' },
               { name: 'Gain Armor', affected_stat: 'armor_points', affected_type: 'positive' },
               { name: 'Decrease Critical Rate ', affected_stat: 'critical_hit_rate', affected_type: 'negative' },
               { name: 'Increase Critical Rate', affected_stat: 'critical_hit_rate', affected_type: 'positive' },
               { name: 'Decrease Critical Multiplier', affected_stat: 'critical_hit_multiplier',
                 affected_type: 'negative' },
               { name: 'Increase Critical Multiplier', affected_stat: 'critical_hit_multiplier',
                 affected_type: 'positive' },
               { name: 'Decrease Dodge Rate', affected_stat: 'dodge_rate', affected_type: 'negative' },
               { name: 'Increase Dodge Rate', affected_stat: 'dodge_rate', affected_type: 'positive' },
               { name: 'Decrease Miss Rate', affected_stat: 'miss_rate', affected_type: 'negative' },
               { name: 'Increase Miss Rate', affected_stat: 'miss_rate', affected_type: 'positive' }])
p 'Effects created'
p 'Equipment creation ...'

Equipment.create([{ name: 'Hylian Shield', position: 'left_hand' },
                  { name: 'Mirror Shield', position: 'left_hand' },
                  { name: 'Wooden Shield', position: 'left_hand', unlocked: true,
                    equipment_effects_attributes: [
                      { effect: Effect.find_by(name: 'Gain Armor'), value: 5 },
                      { effect: Effect.find_by(name: 'Decrease Miss Rate'), value: 2 }
                    ] },
                  { name: 'Deku Shield', position: 'left_hand', unlocked: true,
                    equipment_effects_attributes: [
                      { effect: Effect.find_by(name: 'Gain Armor'), value: 5 },
                      { effect: Effect.find_by(name: 'Increase Critical Rate'), value: 2 }
                    ] },
                  { name: 'Gerudo Shield', position: 'left_hand' },
                  { name: 'Iron Shield', position: 'left_hand' },
                  { name: 'Sacred Shield', position: 'left_hand' },
                  { name: 'Master Sword', position: 'right_hand' },
                  { name: "Smith's Sword", position: 'right_hand', unlocked: true,
                    equipment_effects_attributes: [
                      { effect: Effect.find_by(name: 'Gain Attack'), value: 0.5 },
                      { effect: Effect.find_by(name: 'Increase Critical Multiplier'), value: 0.5 }
                    ] },
                  { name: 'Practice Sword', position: 'right_hand', unlocked: true,
                    equipment_effects_attributes: [
                      { effect: Effect.find_by(name: 'Gain Attack'), value: 0.5 },
                      { effect: Effect.find_by(name: 'Increase Dodge Rate'), value: 5 }
                    ] },
                  { name: 'Giant Knife', position: 'right_hand' },
                  { name: 'Kokiri Sword', position: 'right_hand' },
                  { name: 'Phantom Sword', position: 'right_hand' },
                  { name: 'Sacred Sword', position: 'right_hand' }])
p "Equipment created"
p 'Image assocation ...'

Equipment.all.each do |equipment|
  equipment.image.attach(io: File.open("app/assets/images/equipments/#{equipment.name.parameterize.underscore}.png"),
                         filename: "#{equipment.name.parameterize.underscore}.png")
end

Character.all.each do |character|
  character.profile_picture.attach(io: File.open("app/assets/images/characters/#{character.name.underscore}.png"),
                                   filename: "#{character.name.underscore}.png")
end
p 'Image association finished'
p 'Seed finished'
