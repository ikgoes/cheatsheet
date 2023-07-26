# dd는 블럭 단위로 파일을 복사하거나 변환하는 명령어
# if    : 입력 대상
# of    : 출력 대상 (성능 테스트 시에는 해당 위치로 생성)
# bs    : 블럭 사이즈
# count : 블럭의 수 (전체 용량은 bs * count)
# oflag : O_DIRECT 플래그를 켜고 write() 호출을 하게 된다. O_DIRECT 플래그를 이용하면 파일시스템의 캐시 영역을 사용하지 않고 바로 디스크로 쓰게 된다. 따라서 디스크 입출력 성능을 측정할 때 반드시 필요하다.

dd if=/dev/zero of=/data/test.obj bs=512K count=200000 oflag=direct

