<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use App\Models\Event;

class EventsSeeder extends Seeder
{
    /**
     * Run the database seeds.
     */
    public function run(): void
    {
        $event = new Event();
        $event->title = "Павловский забег";
        $event->date = '2026-02-15';
        $event->save();
        
        $event = new Event();
        $event->title = "Сосновка, эстафета";
        $event->date = '2026-02-21';
        $event->save();

    }
}
