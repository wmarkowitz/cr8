class type entity_type =
  object 
    method get_attack : int
    method get_defense : int
    method get_health : int
    method is_down : bool

    method deal_damage : int -> unit
    method restore_health : int -> unit
  end;;

class entity (base_attack : int) (base_defense : int) (base_hp : int) : entity_type =
  object(this)
    val attack = base_attack
    val defense = base_defense
    val max_hp = base_hp
    val mutable hp = base_hp

    method get_attack = attack
    method get_defense = defense
    method get_health = hp
    method is_down = this#get_health <= 0

    method deal_damage (dmg : int) = hp <- hp - dmg
    method restore_health (res : int) = hp <- min (hp + res) max_hp
  end;;

module FightSimulator =
  struct
    let attack (attacker : entity_type) (defender : entity_type) : unit =
      let damage = max (attacker#get_attack - defender#get_defense) 0 in
      defender#deal_damage damage;;

    let rec battle (first : entity_type) (second : entity_type) : entity_type =
      assert(not first#is_down);
      assert(not second#is_down);
      attack first second;
      if second#is_down then first else battle second first;;
  end;;

class type weapon_type =
  object
    method get_attack : int
    method get_defense : int
  end;;

class weapon (atk : int) (def : int) : weapon_type =
  object
    (* These vals are technically optional, but in case we want to add setters later, I find it useful *)
    val attack = atk
    val defense = def

    method get_attack = attack
    method get_defense = defense
  end;;

class sword (atk : int) : weapon_type =
  object
    inherit weapon atk 0
  end;;

class shield (def : int) : weapon_type =
  object
    inherit weapon 0 def
  end;;

class type use_item_type =
  object
    method use : entity -> unit
  end

class use_item (effect : entity -> unit) =
  object
    method use = effect
  end;;

class equippable_entity (base_attack : int) (base_defense) (base_hp : int) =
  object(this)
    inherit entity base_attack base_defense base_hp as super

    val mutable equipped_weapon = new weapon 0 0
    val mutable item_list = []

    method! get_attack = super#get_attack + equipped_weapon#get_attack
    method! get_defense = super#get_defense + equipped_weapon#get_defense

    method equip (to_equip : weapon_type) = equipped_weapon <- to_equip

    method add_item (item: use_item_type) = item_list <- item :: item_list
    method use_next_item_on_self () = 
      match item_list with
      | item :: tl -> item_list <- tl; item#use (this :> entity_type)
      | [] -> () ;
    
  end;;

let my_equippable = new equippable_entity 3 3 10 in
my_equippable#equip (new weapon 4 1);
let other_ent = new entity 5 5 12 in
FightSimulator.battle (my_equippable :> entity_type) other_ent;;
