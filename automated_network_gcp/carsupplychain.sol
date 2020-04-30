pragma solidity >=0.4.21 <0.6.0;

contract ProductManagement {
    struct Part{
        address manufacturer;
        string serial_number;
        string part_type;
        string creation_date;
        address ownpart;
        bytes32 part_hash;
        bool part_used;
    }

    struct Product{
        address manufacturer;
        string serial_number;
        string product_type;
        string creation_date;
        bytes32[] partslist;
        bytes32 registration_hash;
        bool registration_done;
        address ownproduct;
        bytes32 product_hash;
        
    }
    
   

    mapping(bytes32 => Part) public parts;
    mapping(bytes32 => Product) public products;
    mapping(address => uint) public access;
    mapping(bytes32 => address) public currentPartOwner;
    mapping(bytes32 => address) public currentProductOwner;
    enum OperationType {PART, PRODUCT}
    event TransferPartOwnership(bytes32 indexed p, address indexed account);
    event TransferProductOwnership(bytes32 indexed p, address indexed account);
    event Parthash(address partmaker,bytes32 hash);
    event Producthash(address productmaker,bytes32 hash);
    event Prodreg(address registerer,bytes32 hash);
    address public owner;
    
    modifier onlyOwner(){
        require(msg.sender==owner);
        _;
    }
    constructor() public{
        owner=msg.sender;
    }
    function give_access_part(address[] memory A1) public onlyOwner{
        uint k;
        for(k=0;k<A1.length;k++){
            access[A1[k]]=1;
        }
    }
    
    function give_access_product(address[] memory A2) public onlyOwner{
        uint l;
        for(l=0;l<A2.length;l++){
            access[A2[l]]=2;
        }
    }
    
    function give_access_reg(address[] memory A3) public onlyOwner{
        uint m;
        for(m=0;m<A3.length;m++){
            access[A3[m]]=3;
        }
    }

    function concatenateInfoAndHash(address a1, string memory s1, string memory s2, string memory s3) private returns (bytes32){
        //First, get all values as bytes
        bytes20 b_a1 = bytes20(a1);
        bytes memory b_s1 = bytes(s1);
        bytes memory b_s2 = bytes(s2);
        bytes memory b_s3 = bytes(s3);

        //Then calculate and reserve a space for the full string
        string memory s_full = new string(b_a1.length + b_s1.length + b_s2.length + b_s3.length);
        bytes memory b_full = bytes(s_full);
        uint j = 0;
        uint i;
        for(i = 0; i < b_a1.length; i++){
            b_full[j++] = b_a1[i];
        }
        for(i = 0; i < b_s1.length; i++){
            b_full[j++] = b_s1[i];
        }
        for(i = 0; i < b_s2.length; i++){
            b_full[j++] = b_s2[i];
        }
        for(i = 0; i < b_s3.length; i++){
            b_full[j++] = b_s3[i];
        }

        //Hash the result and return
        return keccak256(b_full);
    }

    function buildPart(string memory serial_number, string memory part_type, string memory creation_date) public returns (bytes32){
        //Create hash for data and check if it exists. If it doesn't, create the part and return the ID to the user
        bytes32 part_hash = concatenateInfoAndHash(msg.sender, serial_number, part_type, creation_date);
        
        require(parts[part_hash].manufacturer == address(0), "Part ID already used");
        require(access[msg.sender]==1);
        bool partused=false;

        Part memory new_part = Part(msg.sender, serial_number, part_type, creation_date,msg.sender,part_hash,partused);
        parts[part_hash] = new_part;
        currentPartOwner[part_hash]=msg.sender;
        emit Parthash(msg.sender,part_hash);
        return part_hash;
    }

    function buildProduct(string memory serial_number, string memory product_type, string memory creation_date, bytes32[] memory part_array) public returns (bytes32){
        
        //Check if all the parts exist, hash values and add to product mapping.
        require(access[msg.sender]==2);
        uint i;
        for(i = 0;i < part_array.length; i++){
            require(parts[part_array[i]].manufacturer != address(0),"Inexistent part used on product");
            require(currentPartOwner[parts[part_array[i]].part_hash]==msg.sender);
            require(parts[part_array[i]].part_used==false);
            parts[part_array[i]].part_used=true;
        }

        //Create hash for data and check if exists. If it doesn't, create the part and return the ID to the user
        bytes32 product_hash = concatenateInfoAndHash(msg.sender, serial_number, product_type, creation_date);
        
        require(products[product_hash].manufacturer == address(0), "Product ID already used");
        bool reg=false;
        bytes32 reg_hash="000";
        Product memory new_product = Product(msg.sender, serial_number, product_type, creation_date, part_array,reg_hash,reg,msg.sender,product_hash);
        products[product_hash] = new_product;
        currentProductOwner[product_hash]=msg.sender;
        emit Producthash(msg.sender,product_hash);
        return product_hash;
    }

    function getParts(bytes32 product_hash) public returns (bytes32[] memory){
        //The automatic getter does not return arrays, so lets create a function for that
        require(products[product_hash].manufacturer != address(0), "Product inexistent");
        return products[product_hash].partslist;
    }
    function doregistration(bytes32 product_hash,address governmentaddress,string memory serialno,string memory product_type,string memory date) public returns (bytes32){
        require(access[msg.sender]==3);
        bytes32 reg_hash=concatenateInfoAndHash(governmentaddress, serialno, product_type,date);
        products[product_hash].registration_hash=reg_hash;
        products[product_hash].registration_done=true;
        emit Prodreg(msg.sender,reg_hash);
        return reg_hash;
    }
    function changeOwnership(uint op_type, bytes32 p_hash, address to) public returns (bool) {
      //Check if the element exists and belongs to the user requesting ownership change
        if(op_type == uint(OperationType.PART)){
            require(currentPartOwner[p_hash] == msg.sender, "Part is not owned by requester");
            currentPartOwner[p_hash] = to;
            parts[p_hash].ownpart=to;
            
            emit TransferPartOwnership(p_hash, to);
        } else if (op_type == uint(OperationType.PRODUCT)){
            require(currentProductOwner[p_hash] == msg.sender, "Product is not owned by requester");
            currentProductOwner[p_hash] = to;
            products[p_hash].ownproduct=to;
            emit TransferProductOwnership(p_hash, to);
            //Change part ownership too
            bytes32[] memory part_list =getParts(p_hash);
            for(uint i = 0; i < part_list.length; i++){
                currentPartOwner[part_list[i]] = to;
                parts[part_list[i]].ownpart=to;
                emit TransferPartOwnership(part_list[i], to);
            }

        }
    }
}

