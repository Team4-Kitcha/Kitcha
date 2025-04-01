#!/bin/bash

# 공통 JAR 저장 디렉토리 초기화
mkdir -p build-artifacts
rm -rf build-artifacts/*

# 복사할 모듈 리스트
modules=(
  "Kitcha-Article"
  "Kitcha-Authentication"
  "Kitcha-Board"
  "Kitcha-Interest"
  "Kitcha-File"
  "Kitcha-BE/API-Gateway"
  "Kitcha-BE/Config-server"
  "Kitcha-BE/eureka"
)

# JAR 복사
for module in "${modules[@]}"
do
  echo "📦 복사 중: $module"
  jar_path="$module/build/libs"

  if compgen -G "$jar_path/*.jar" > /dev/null; then
    for jar in "$jar_path"/*.jar; do
      if [[ "$jar" != *-plain.jar ]]; then
        cp "$jar" build-artifacts/
        echo "✅ 복사 완료: $jar"
      else
        echo "⏭️  제외: $jar"
      fi
    done
  else
    echo "⚠️  $module 에서 JAR 파일을 찾을 수 없습니다."
  fi
done

echo "🎉 최종 실행 JAR 목록이 build-artifacts/ 에 정리 완료되었습니다."
