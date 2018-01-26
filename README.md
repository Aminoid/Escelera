# Escelera
This Repo hosts the code for Car Rental App based on Ruby and Rails as a part of OODD course.

[1]: http://escalera.herokuapp.com/

## Team Members
* Amit Kanwar (akanwar2)
* Kamal Sharma (ksharma5)
* Rachit Agarwal (ragarwa7)

## Deployment
The production build of the app is deployed on [Heroku][1]

## Test Data
* Superadmin (email:'sadmin@abc.com', password: 'sadmin')
* admin(email: 'amith@abc.com', password: 'amith123')
## Development
To run the app locally, follow these stops:

### Install gems
```
bundle install --without production
```

### Complete Database Migrations
```
rails db:migrate
```

### Add pre-configured superadmins, admins and users
```
rails db:seed
```

### Run server
```
rails server
```

Your app will run on http://localhost:3000

### Site Navigation Guide 

### SuperAdmin

Login with admin credentials (Ex: email: 'ybajori@ncsu.edu', password: 'yash123')

```
●  Create new superadmins : Manage -> SuperAdmin -> Create SuperAdmin
●  View the list of superadmins and their profile details (except password): Manage -> SuperAdmin

**Validations**

●  Superadmin will not able to delete other superadmins
```


### Admin

Login with admin credentials (Ex: email: 'amith@abc.com', password: 'amith123')

● Manage Admins
```
●  View the list of all the admins: Manage -> Admin
●  Create new admins: Manage -> Admin -> Create New
●  Delete admins (except themselves and the superadmins): Manage -> Admin -> Create New

**Validations**

●  Admin cannot delete himself since his details are not included while admin tries to manage other admins

```

● Manage Cars
```
●  View the list of all Cars with attributes: Manage -> Cars
    ○ Status attributes shows the status of car at present time.
    ○ For details, select "All bookings" option for a particular car.
    
●  Add a Car to the system: Manage -> Cars -> Add Car
    ● To update the status of a new car (by default status is Available):
         ○ Status Reserved: Manage -> Cars -> select Book for new car -> Fill form -> Create Booking
            (Since a new booking need to be created for this)
         ○ Status Checkedout: Home -> Check Out (for a particular car)
      
●  Edit the attributes of a Car: Manage -> Cars -> Edit
    ●  To update the status of a new car (by default status is Available):
         ○ Status Reserved: Manage -> Cars -> select Book for new car -> Fill form -> Create Booking
                (Since a new booking need to be created for this)
         ○ Status Checkedout: Home -> Check Out (for a particular car)
         
●   View the checkout history of a car: Manage -> Cars -> All Booking (for specific car)
●   Delete a car from the system: Manage -> Cars -> Delete (for specific car)

**Validations**

●  Admin cannot directly delete car with status Reserved or Checkedout.
●  While editing or creating a new car, admin needs to update bookings for the same.
●  Admin cannot cancel booking for the cars which are already checkedout

```
● Manage Users

```
●   List all customers and profile attributes or delete users: Manage -> Users
●   View the checkout history of a customer: Manae -> Users -> Show
●   Book car for user: Manage -> Car -> select book option for a particular car -> select user and booking dates -> book

**Validations**

●  Admin cannot delete user having any pending bookings

```

### User
Sign up or Login with user credentials (Ex: email: 'rac@rac.com', password: 'rac123')

```
●   Edit their own profile: Select profile from dropdown on right corner navigation
●   Search cars using location or model or manufacturer or style: Home -> Rent a Car
●   Return a checked-out car or view their own checkout history: Manage -> Bookings


**Validations**

●  User cannot Rent a Car with any pending bookings

```
