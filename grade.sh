#!/usr/bin/env bash

SCORE=0
TOTAL=100

echo "=========================================="
echo "      RUNNING DOCKER CLI GRADER           "
echo "=========================================="

# Check Dockerfile & Compose exist
echo -n "Checking required files... "
if [ -f "Dockerfile" ] && [ -f "compose.yaml" ] && [ -f "app/diagnostic.sh" ] && [ -f "app/health-check.sh" ]; then
    echo "PASS (+20)"
    SCORE=$((SCORE + 20))
else
    echo "FAIL"
fi

# Check Docker Image Build
echo -n "Checking Docker image build... "
if docker build -t diagnostic-cli:test . >/dev/null 2>&1; then
    echo "PASS (+20)"
    SCORE=$((SCORE + 20))
else
    echo "FAIL"
fi

# Check system command
echo -n "Testing system command... "
if docker run --rm diagnostic-cli:test system | grep -q "SYSTEM DIAGNOSTIC"; then
    echo "PASS (+20)"
    SCORE=$((SCORE + 20))
else
    echo "FAIL"
fi

# Check network command
echo -n "Testing network command... "
if docker run --rm diagnostic-cli:test network 127.0.0.1 | grep -q "NETWORK DIAGNOSTIC"; then
    echo "PASS (+20)"
    SCORE=$((SCORE + 20))
else
    echo "FAIL"
fi

# Check Git Commit History (min 5 commits)
echo -n "Checking Git commit history... "
COMMIT_COUNT=$(git rev-list --count HEAD 2>/dev/null || echo 0)
if [ "$COMMIT_COUNT" -ge 3 ]; then
    echo "PASS ($COMMIT_COUNT commits) (+20)"
    SCORE=$((SCORE + 20))
else
    echo "FAIL ($COMMIT_COUNT commits)"
fi

echo "=========================================="
echo "FINAL SCORE: $SCORE / $TOTAL"
echo "=========================================="
