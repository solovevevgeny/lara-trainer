<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\User;

class UserSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $user = new User();
        $user->is_admin = 1;
        $user->is_trainer = 0;
        $user->is_athlete = 1;
        $user->name = "Соловьев Евгений";
        $user->email = "evgeny.solovev@gmail.com";
        $user->phone = "+79217767600";
        $user->trainer_id = 2;
        $user->password = "13123";
        $user->save();

        $user = new User();
        $user->is_admin = 1;
        $user->is_trainer = 1;
        $user->is_athlete = 1;
        $user->name = "Науменко Александр";
        $user->email = "alex.nau@gmail.com";
        $user->phone = "+79211231313";
        $user->trainer_id = 2;
        $user->password = "13123";
        $user->save();

        $user = new User();
        $user->is_admin = 0;
        $user->is_trainer = 0;
        $user->is_athlete = 1;
        $user->name = "Ксения Иванова";
        $user->email = "xenia.iv@gmail.com";
        $user->phone = "+79211231414";
        $user->trainer_id = 2;
        $user->password = "13123";
        $user->save();


    }
}
