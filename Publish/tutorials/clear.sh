find . -name "*.asm" -type f -delete
find . -name "*.prg" -type f -delete
find . -name "*.sym" -type f -delete
find . -name "*.gb" -type f -delete
find . -name "*.o" -type f -delete
find . -name "*.dup" -type f -delete
find . -name "*.nes" -type f -delete
find . -name "*.com" -type f -delete

find . -name "*.trse" -type f  -exec sed -i /project_path/d {} +
find . -name "*.trse" -type f  -exec sed -i /open_files/d {} +
find . -name "*.trse" -type f  -exec sed -i /current_file/d {} +

find . -name .backup -exec rm -rf {} \;

echo "open_files =, Hello.ras" >> C64/Tutorials/C64_Tutorials.trse
echo "open_files =, RogueBurgerOne.ras" >> C64/TutorialGame_RogueBurgerOne/RogueBurgerOne.trse
echo "open_files =, demo_part2_empty.ras" >> C64/DemoMaker/demomaker.trse
echo "open_files =, example5_single_sprite.ras, example5_single_sprite.fjo" >> C64/DemoEffects_raytracer/DemoEffects_raytracer.trse
echo "open_files =, main.ras" >> C64/Disk_loader_project/disk_loader_project.trse
echo "open_files =, part3.ras" >> C64/TutorialGame_Introduction/Introductiongame.trse
echo "open_files =, intro.ras" >> C64/4kDreams/4kDreams.trse
echo "open_files =, main.ras" >> C64/16kb_cartridge_project/crt_project.trse
echo "open_files =, main.ras" >> C64/disk_demo_project/disk_demo_project.trse

echo "open_files =, graveintentions.ras" >> CrossPlat/GraveIntentions/GraveIntentions.trse

echo "open_files =, player.ras" >> C64/MusicPlayer/dualsidplayer.trse

echo "open_files =, floskel.ras" >> C64/Floskel/floskel.trse

echo "open_files =, info.rtf" >> C64/demoeffects/c64_demoeffects.trse
