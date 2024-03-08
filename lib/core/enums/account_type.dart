enum AccountTypeEnum{
  owner('owner'),
  barber('barber'),
  user('user');


  const AccountTypeEnum(this.type);
  final String type;
}

// using an extension
// enhanced enums
extension ConvertAccountType on String{
  AccountTypeEnum toAccountTypeEnum(){
    switch(this){
      case 'owner':
        return AccountTypeEnum.owner;
      case 'barber':
        return AccountTypeEnum.barber;
      case 'user':
        return AccountTypeEnum.user;
      default:
        return AccountTypeEnum.user;
    }
  }
}