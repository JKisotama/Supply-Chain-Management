module SupplyChain {
    struct Order {
        id: u64,
        item_id: u64,
        quantity: u64,
        customer: address,
        status: vector<u8>,
    }

    resource struct OrderList {
        orders: vector<Order>,
    }

    public fun initialize_orders(account: &signer) {
        let orders = OrderList { orders: vector[] };
        move_to(account, orders);
    }

    public fun create_order(account: &signer, id: u64, item_id: u64, quantity: u64, customer: address) {
        let orders = borrow_global_mut<OrderList>(Signer::address_of(account));
        let new_order = Order { id, item_id, quantity, customer, status: b"Pending".to_vec() };
        vector::push_back(&mut orders.orders, new_order);
    }

    public fun update_order_status(account: &signer, id: u64, new_status: vector<u8>) {
        let orders = borrow_global_mut<OrderList>(Signer::address_of(account));
        let index = vector::index_where(&orders.orders, (order: &Order) => order.id == id);
        *&mut orders.orders[index].status = new_status;
    }

    public fun get_orders(account: &signer): &OrderList {
        borrow_global<OrderList>(Signer::address_of(account))
    }
}
