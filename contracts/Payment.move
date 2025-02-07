module SupplyChain {
    struct Payment {
        order_id: u64,
        amount: u64,
        payer: address,
        status: vector<u8>,
    }

    resource struct PaymentList {
        payments: vector<Payment>,
    }

    public fun initialize_payments(account: &signer) {
        let payments = PaymentList { payments: vector[] };
        move_to(account, payments);
    }

    public fun create_payment(account: &signer, order_id: u64, amount: u64, payer: address) {
        let payments = borrow_global_mut<PaymentList>(Signer::address_of(account));
        let new_payment = Payment { order_id, amount, payer, status: b"Pending".to_vec() };
        vector::push_back(&mut payments.payments, new_payment);
    }

    public fun update_payment_status(account: &signer, order_id: u64, new_status: vector<u8>) {
        let payments = borrow_global_mut<PaymentList>(Signer::address_of(account));
        let index = vector::index_where(&payments.payments, (payment: &Payment) => payment.order_id == order_id);
        *&mut payments.payments[index].status = new_status;
    }

    public fun get_payments(account: &signer): &PaymentList {
        borrow_global<PaymentList>(Signer::address_of(account))
    }
}
