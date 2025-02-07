module SupplyChain {
    struct InventoryItem {
        id: u64,
        name: vector<u8>,
        quantity: u64,
        supplier: address,
    }

    resource struct Inventory {
        items: vector<InventoryItem>,
    }

    public fun initialize_inventory(account: &signer) {
        let inventory = Inventory { items: vector[] };
        move_to(account, inventory);
    }

    public fun add_item(account: &signer, id: u64, name: vector<u8>, quantity: u64, supplier: address) {
        let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
        let new_item = InventoryItem { id, name, quantity, supplier };
        vector::push_back(&mut inventory.items, new_item);
    }

    public fun update_quantity(account: &signer, id: u64, new_quantity: u64) {
        let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
        let index = vector::index_where(&inventory.items, (item: &InventoryItem) => item.id == id);
        *&mut inventory.items[index].quantity = new_quantity;
    }

    public fun get_inventory(account: &signer): &Inventory {
        borrow_global<Inventory>(Signer::address_of(account))
    }
}
