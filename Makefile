CC = gcc
CFLAGS = -g -Wall -Wextra -O2 -pthread
TARGET = main
SOURCES = main.c
OBJECTS = $(SOURCES:.c=.o)

all: $(TARGET)

$(TARGET): $(OBJECTS)
	$(CC) $(CFLAGS) -o $(TARGET) $(OBJECTS)
	rm -f *.o
	@echo "Build complete! Run with: ./$(TARGET)"

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	rm -f $(OBJECTS) $(TARGET)
	@echo "Cleaned build files"

install: $(TARGET)
	sudo mkdir -p /opt/streamer
	sudo cp -r * /opt/streamer
	@echo "Installed to /opt/streamer/$(TARGET)"

uninstall:
	sudo rm /opt/streamer/$(TARGET)
	sudo rm /opt/streamer/*.html
	sudo rm /opt/streamer/*.md
	sudo rm /opt/streamer/*.c
	sudo rm /opt/streamer/*.ico
	@echo "Uninstalled $(TARGET) and related HTML files. Media left intact"
	sudo rm /opt/streamer/Makefile

debug: CFLAGS += -g -DDEBUG
debug: clean $(TARGET)
	@echo "Debug build complete"

check:
	@echo "Checking dependencies..."
	@which gcc >/dev/null || echo "ERROR: gcc not found"
	@ls main_pages/ >/dev/null 2>&1 || echo "WARNING: main_pages/ directory not found"
	@ls movies/ >/dev/null 2>&1 || echo "WARNING: movies/ directory not found" 
	@ls television/ >/dev/null 2>&1 || echo "WARNING: television/ directory not found"
	@echo "Check complete"


help:
	@echo "Available targets:"
	@echo "  clean     - Remove build files"
	@echo "  debug     - Build with debug symbols"
	@echo "  install   - Install to /opt"
	@echo "  uninstall - Remove from /opt"
	@echo "  check     - Check for dependencies and directories"
	@echo "  help      - Show this help"


.PHONY: all clean install uninstall debug run check help
