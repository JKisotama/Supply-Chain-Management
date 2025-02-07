module SupplyChain {
    struct Supplier {
        id: u64,
        name: vector<u8>,
        address: vector<u8>,
    }

    resource struct SupplierList {
        suppliers: vector<Supplier>,
    }

    public fun initialize_suppliers(account: &signer) {
        let suppliers = SupplierList { suppliers: vector[] };
        move_to(account, suppliers);
    }

    public fun add_supplier(account: &signer, id: u64, name: vector<u8>, address: vector<u8>) {
        let suppliers = borrow_global_mut<SupplierList>(Signer::address_of(account));
        let new_supplier = Supplier { id, name, address };
        vector::push_back(&mut suppliers.suppliers, new_supplier);
    }

    public fun get_suppliers(account: &signer): &SupplierList {
        borrow_global<SupplierList>(Signer::address_of(account))
    }
}
