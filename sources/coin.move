module coin::cit {
    use sui::coin::{Self, TreasuryCap};
    use sui::url::{Self, Url};

    public struct CIT has drop {}

    fun init(witness: CIT, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            witness, 
            6, 
            b"CIT", 
            b"CIT Token", 
            b"CIT is the native token of Crypto Invest Terminal.", 
            option::some<Url>(url::new_unsafe_from_bytes(b"https://6mlzu7yihlt2drajl5idor3p5nyt7kwtgmnmudptt4tx7ff7fzkq.arweave.net/8xeafwg656HECV9QN0dv63E_qtMzGsoN858nf5S_LlU")), 
            ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, ctx.sender());
    }

    public fun mint(
        treasury_cap: &mut TreasuryCap<CIT>, 
        amount: u64, 
        recipient: address, 
        ctx: &mut TxContext,
    ) {
        let coin = coin::mint(treasury_cap, amount, ctx);
        transfer::public_transfer(coin, recipient)
    }
}
