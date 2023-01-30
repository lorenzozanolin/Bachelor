#include <stdio.h>
#include <sys/stat.h>
#include <sys/types.h>

int main() {

    struct stat mystat;
    //uso fstat al posto di stat se devo usare un filedescriptor al posto di un pathname
    stat("./socket_server_Template.c", &mystat);
    dev_t device_id = mystat.st_dev;
    ino_t inode_number = mystat.st_ino;
    mode_t file_type_and_permissions = mystat.st_mode;
    nlink_t number_of_non_symbolic_links = mystat.st_nlink;
    uid_t UID = mystat.st_uid;
    gid_t GID = mystat.st_gid;
    dev_t device_type = mystat.st_rdev;
    off_t file_size = mystat.st_size;
    time_t last_access_time = mystat.st_atime;
    time_t last_modify_time = mystat.st_mtime;
    time_t time_of_creation = mystat.st_ctime;
    long block_size = mystat.st_blksize;
    long blocks_number = mystat.st_blocks;

    return 0;

}