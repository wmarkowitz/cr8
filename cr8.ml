exception Empty ;;

class type ['a] stack_i = 
    object
        method pop : unit -> 'a
        method push : 'a -> unit
    end ;;

class ['a] stack : ['a] stack_i =
    object(this)
        val mutable internal : 'a list = []
    method push e =
        internal <- e :: internal
    method pop () =
        match internal with
        | [] -> raise Empty
        | h :: t -> internal <- t; h
    end

(* Part 1 *)

(* The class type for weapons! *)
class type weapon_type =
  object
    method get_attack : int
    method get_defense : int
  end;;


(*  A weapon should have certain "stats" associated with it, attack and defense
    Ensure that anything created by this constructor or the following ones has type weapon_type! *)
class weapon (atk : int) (def : int) =
  object
    method get_attack = failwith "weapon not implemented"
    method get_defense = failwith "weapon not implemented"
  end


(* The class type for entities! *)
class type entity_type =
  object 
    method get_attack : int
    method get_defense : int
    method get_health : int
    method is_down : bool

    method deal_damage : int -> unit
    method restore_health : int -> unit
  end;;


(* The constructor for entities *)
class entity (base_attack : int) (base_defense : int) (base_hp : int) : entity_type =
  object(this)
    (* Let's hold onto values for the attack, defense, max_hp, and current_hp! *)

    (* Getters for public stats! Note that we don't want max_hp to be public *)
    method get_attack = failwith "entity not implemented yet"
    method get_defense = failwith "entity not implemented yet"
    method get_health = failwith "entity not implemented yet"

    (* Should return true if the entity is out of hp *)
    method is_down = failwith "entity not implemented yet"

    (* Update entity hp based on damage taken (do not consider attack/defense stats at the moment) *)
    method deal_damage (dmg : int) = failwith "entity not implemented yet"

    (* Update entity hp based on healing done. Do not exceed maximum hp *)
    method restore_health (res : int) = failwith "entity not implemented yet"
  end

class ones_stack =
    object(this)
    inherit [int] stack as super
    method! pop () =
      try super#pop () with
        Empty -> 0
    end


(* Part 2 *)

(* A sword has no defensive value, only offensive *)
class sword (atk : int) =
  object
  end

(* A shield has no offensive value, only defensive *)
class shield (def : int) =
  object
  end

module FightSimulator =
  struct
    (* 
      Given an attacker and a defender, update stats accordingly
      Consider the damage formula to be damage = attacker's attack - defender's defense
      Attacks should not heal the defender! 
    *)
    let attack (attacker : entity_type) (defender : entity_type) : unit = failwith "FightSimulator not implemented yet"

    (* 
      Have two entities battle until one is down for the count. Attacks are sequential, so if an entity is downed
      by an attack, they do not get another attack afterward.
      
      The first entity gets to attack first 
    *)
    let rec battle (first : entity_type) (second : entity_type) : entity_type = failwith "FightSimulator not implemented yet"
  end;;

(* 
  Equippable entities should have the same functionality as normal entities! 
  These entities should have augmented stats based on whatever weapon is equpped, however. 
*)
class equippable_entity (base_attack : int) (base_defense) (base_hp : int) =
  object
    (* Initialize any equippable entity with an "empty" weapon (one with zero stats) *)
    val mutable equipped_weapon = failwith "Equippable not implemented"

    (* Ensure that this shares entity functionality! *)

    method equip = failwith "Equippable not implemented"

    (* Are there any other changes we need to make? *)
  end

(* Uncomment below when implementation above is complete *)
(* Why doesn't this code below compile??? *)
(* 
  let my_equippable = new equippable_entity 3 3 10 in
  my_equippable#equip (new weapon 4 1);
  let other_ent = new entity 5 5 12 in
  FightSimulator.battle my_equippable other_ent;;
 *)