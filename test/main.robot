*** Settings ***
Library  SeleniumLibrary
Library  OperatingSystem
Library  DatabaseLibrary
Resource  ../Ressource/Variables.robot
*** Test Cases ***
Test de connection à la base de données
    Connect To Database Using Custom Params  pymysql  database='${db}',user='root',password='',host='localhost'
Test de recuperation de la liste des utilisateurs
    ${users}  Query  select * from users
    Log Many  ${users}
    Should Be True    ${users}
Test de recuperation de la liste des plats de la base de données
    ${product}  Query  select * from dishes
    Log Many  ${product}
    Should Be True  ${product}
Test de recuperation des commandes des utilisateurs
    ${order}  Query  select * from users_orders
    Log Many  ${order}
    Should Be True  ${order}
Test de recuperation des restaurant
    ${rest}  Query  SELECT * from restaurant
    Log Many  ${rest}
    Should Be True  ${rest}
Test de recuperation commentaires des utilisateurs
    ${comment}  Query  select * from remark
    Log Many  ${comment}
    Should Be True  ${comment}
Test de recuperation des categories de plats
    ${category}  Query  select * from res_category
    Log Many  ${category}
    Should Be True  ${category}

# Tests de mise à jour des informations de la BD

Test mise à jour des informations utilisateurs
    ${result}  Set Variable  update users set username='yvan2' where f_name='yvan'
    Execute Sql String  ${result}
    ${result}  Query  select * from users
    Should Be True    ${result}

Test de mise à jour des informations des plats de la BD
    ${result}  Set Variable  update dishes set price='25.50' where d_id=1
    Execute Sql String  ${result}
    ${result}  Query  select * from dishes
    Should Be True    ${result}
Test de mise à jour des informations de restaurants
    ${result}  Set Variable  update restaurant set email='tarvern@gmail.com' where c_id=1
    Execute Sql String  ${result}
    ${result}  Query  select * from restaurant
    Should Be True    ${result}
Test de mise à jour des informations des categories
    ${result}  Set Variable  update res_category set c_name='Cameroon' where c_id=1
    Execute Sql String  ${result}
    ${result}  Query  select * from res_category
    Should Be True  ${result}
Test de mise à jour des informations des commandes de plats
    ${result}  Set Variable  update users_orders set quantity=5 where o_id=1
    Execute Sql String  ${result}
    ${result}  Query  select * from users_orders
    Should Be True  ${result}   
Test de supression de commande
    ${result}  Set Variable  delete from users_orders where o_id=1
    Execute Sql String  ${result}
    ${result}  Query  select * from users_orders
    Should Be True  ${result}  
Test de suppression d'utilisateur
    ${result}  Set Variable  delete from users where f_name='yvan'
    Execute Sql String  ${result}
    ${result}  Query  select * from users
    Should Be True  ${result}

Test de creation d'utilisateur
    ${result}  Set Variable  INSERT INTO `users` (`u_id`, `username`, `f_name`, `l_name`, `email`, `phone`, `password`, `address`, `status`, `date`) VALUES (NULL, 'brenda', 'brenda', 'raissa', 'brenda@gmail.Com', '0698076337', '4dc064c4da487fb26569f6698c060a5b', 'Douala', '1', '2023-11-14 17:23:23');
    Execute Sql String  ${result}
    ${result}  Query  select * from users
    Should Be True  ${result}

Test de creation de commande
    ${result}  Set Variable  INSERT INTO `users_orders` (`o_id`, `u_id`, `title`, `quantity`, `price`, `status`, `date`) VALUES (NULL, '6', 'Yorkshire Lamb Patties', '1', '14.00', 'closed', '2022-05-27 14:04:33')
    Execute Sql String  ${result}
    ${result}  Query  select * from users_orders
    Should Be True  ${result}
Test de creation d'un nouveau restaurant
    ${result}  Set Variable  INSERT INTO `restaurant` (`rs_id`, `c_id`, `title`, `email`, `phone`, `url`, `o_hr`, `c_hr`, `o_days`, `address`, `image`, `date`) VALUES (NULL, '2', 'Eataly', 'eataly@gmail.com', '0557426406', 'www.eataly.com', '11am', '9pm', 'Mon-Sat', '800 Boylston St, Boston', '606d720b5fc71.jpg', '2022-05-27 09:06:41');
    Execute Sql String  ${result}
    ${result}  Query  select * from restaurant
    Should Be True  ${result}
Test de creation d'une nouvelle categorie de restaurant
    ${result}  Set Variable  INSERT INTO `res_category` (`c_id`, `c_name`, `date`) VALUES (NULL, 'Cameroon', '2023-11-14 19:09:50');
    Execute Sql String  ${result}
    ${result}  Query  select * from res_category
    Should Be True  ${result}
Test de creation d'un nouvel utilisateur
    ${result}  Set Variable  INSERT INTO `users` (`u_id`, `username`, `f_name`, `l_name`, `email`, `phone`, `password`, `address`, `status`, `date`) VALUES (NULL, 'brenda', 'brenda', 'raissa', 'brenda@gmail.Com', '0698076337', '4dc064c4da487fb26569f6698c060a5b', 'Douala', '1', '2023-11-14 17:23:23');
    Execute Sql String  ${result}
    ${result}  Query  select * from users
    Should Be True  ${result}
Test de deconnection de la base de données
    Disconnect From Database