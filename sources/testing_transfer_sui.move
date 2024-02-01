module testing_transfer_sui::account {
    use sui::transfer::{Self, Receiving};
    use sui::coin::{Self, Coin};
    use sui::object::{Self , UID};
    use sui::tx_context::{Self , TxContext};
    use sui::balance::{Self , Balance};
    use std::debug::print;
    use std::type_name::{Self , TypeName};
    use sui::event;
     use std::ascii::{Self, String};

     struct AccountData<phantom T> has key {
        id: UID,
        coin: Balance<T>
    }

   struct TokenNameEvent has copy , drop{
            coin_type_myyyyyy : TypeName, 
            name : String
        }
    
    public entry fun empty<T>(ctx : &mut TxContext) {
       let a =  AccountData<T>{
            id: object::new(ctx),
            coin : balance::zero<T>()
        };

        transfer::transfer(a , tx_context::sender(ctx))
    }

    public entry fun accept_payment<T>(account: &mut AccountData<T>, sent: Receiving<Coin<T>>): u64  {
        let coin = transfer::public_receive(&mut account.id, sent);
        print(&coin);
        let balance : Balance<T> = coin::into_balance(coin);
        print(&balance);
          let name = type_name::get<T>();
         let token_name = type_name::borrow_string(&name);
        event::emit(TokenNameEvent{
            coin_type_myyyyyy :copy name, 
            name : *token_name
        });
        balance::join(&mut account.coin ,balance)
    }


    public entry fun transfer_account<T>(c: Coin<T>, to: address, _ctx: &mut TxContext) {
        transfer::public_transfer(c, to);
         let name = type_name::get<T>();
         let token_name = type_name::borrow_string(&name);
        event::emit(TokenNameEvent{
            coin_type_myyyyyy :copy name, 
            name : *token_name
        });
    }

}

//0x74f4c499cd7266d1f315ad678b014e8544c18bb3a53c2f53d8994ccdbb73a25f

//coin
// 0x41c29174d682e42187ad544622d734e3e5d80d2c1383018cd979581fab200cf4

// cointype :
// 0x0000000000000000000000000000000000000000000000000000000000000002::sui::SUI