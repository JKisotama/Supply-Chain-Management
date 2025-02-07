module SupplyChain {
    use 0x1::Signer;
    use 0x1::Vector;
    use 0x1::Option;
    use SupplyChain::SupplierModule::{Supplier};
    use SupplyChain::OrderModule::{Order};
    use SupplyChain::PaymentModule::{Payment};

    struct InventoryItem {
        id: u64,
        name: vector<u8>,
        quantity: u64,
        supplier: address,
        price: u64,
        expiration_date: u64,
    }

    resource struct Inventory {
        items: vector<InventoryItem>,
        suppliers: vector<Supplier>,
        orders: vector<Order>,
        payments: vector<Payment>,
    }

    public fun initialize_inventory(account: &signer) {
        let inventory = Inventory {
            items: vector[],
            suppliers: vector[],
            orders: vector[],
            payments: vector[],
        };
        move_to(account, inventory);
    }

    public fun add_item(
        account: &signer,
        id: u64,
        name: vector<u8>,
        quantity: u64,
        supplier: address,
        price: u64,
        expiration_date: u64
    ) {
        let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
        let new_item = InventoryItem { id, name, quantity, supplier, price, expiration_date };
        vector::push_back(&mut inventory.items, new_item);
    }

    public fun update_item(
        account: &signer,
        id: u64,
        name: vector<u8>,
        quantity: u64,
        supplier: address,
        price: u64,
        expiration_date: u64
    ) {
        let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
        let index = vector::index_where(&inventory.items, (item: &InventoryItem) => item.id == id);
        let item = &mut inventory.items[index];
        item.name = name;
        item.quantity = quantity;
        item.supplier = supplier;
        item.price = price;
        item.expiration_date = expiration_date;
    }

    public fun remove_item(account: &signer, id: u64) {
        let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
        let index = vector::index_where(&inventory.items, (item: &InventoryItem) => item.id == id);
        vector::remove(&mut inventory.items, index);
    }

    public fun get_item(account: &signer, id: u64): Option<InventoryItem> {
        let inventory = borrow_global<Inventory>(Signer::address_of(account));
        let index = vector::index_where(&inventory.items, (item: &InventoryItem) => item.id == id);
        if (index == vector::length(&inventory.items)) {
            return Option::none<InventoryItem>();
        }
        Option::some(vector::borrow(&inventory.items, index))
    }

    public fun add_supplier(account: &signer, id: u64, name: vector<u8>, address: address) {
        let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
        let new_supplier = Supplier { id, name, address };
        vector::push_back(&mut inventory.suppliers, new_supplier);
    }

    public fun place_order(
        account: &signer,
        id: u64,
        item_id: u64,
        quantity: u64,
        total_price: u64,
        buyer: address
    ) {
        let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
        let new_order = Order { id, item_id, quantity, total_price, buyer, status: b"Pending" };
        vector::push_back(&mut inventory.orders, new_order);
    }

    public fun update_order_status(account: &signer, id: u64, new_status: vector<u8>) {
        let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
        let index = vector::index_where(&inventory.orders, (order: &Order) => order.id == id);
        *&mut inventory.orders[index].status = new_status;
    }

    public fun make_payment(
        account: &signer,
        id: u64,
        order_id: u64,
        amount: u64,
        payer: address
    ) {
        let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
        let new_payment = Payment { id, order_id, amount, payer, status: b"Completed" };
        vector::push_back(&mut inventory.payments, new_payment);
    }

    public fun get_inventory(account: &signer): &Inventory {
        borrow_global<Inventory>(Signer::address_of(account))
    }

    public fun transfer_item(
        account: &signer,
        recipient: address,
        id: u64,
        quantity: u64
    ) {
        let inventory = borrow_global_mut<Inventory>(Signer::address_of(account));
        let index = vector::index_where(&inventory.items, (item: &InventoryItem) => item.id == id);
        let item = &mut inventory.items[index];
        assert!(item.quantity >= quantity, 1);
        item.quantity = item.quantity - quantity;

        let recipient_inventory = borrow_global_mut<Inventory>(recipient);
        let new_item = InventoryItem {
            id: item.id,
            name: item.name,
            quantity: quantity,
            supplier: item.supplier,
            price: item.price,
            expiration_date: item.expiration_date,
        };
        vector::push_back(&mut recipient_inventory.items, new_item);
    }
}