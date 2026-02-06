<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\Train;

class TrainSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $train = new Train();
        $train->title = "Фартлек";
        $train->description = "10'@5:40 / 20'@5:00 / 10'@4:40 / 10'@5:40";
        $train->save();

        $train = new Train();
        $train->title = "Длительная 60минут";
        $train->description = "60'@6:00";
        $train->save();

        $train = new Train();
        $train->title = "Сосновка, 200м";
        $train->description = "план 35сек";
        $train->event_id = 3;
        $train->save();


    }
}
