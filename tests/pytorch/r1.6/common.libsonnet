# Copyright 2020 Google LLC
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     https://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

local common = import "../common.libsonnet";
local mixins = import "templates/mixins.libsonnet";
local volumes = import "templates/volumes.libsonnet";

{
  PyTorchTest:: common.PyTorchTest {
    frameworkPrefix: "pt-1.6",
    tpuSettings+: {
      softwareVersion: "pytorch-1.6",
    },
    imageTag: "r1.6",
  },
  PyTorchXlaDistPodTest:: common.PyTorchXlaDistPodTest {
    frameworkPrefix: "pt-1.6",
    tpuSettings+: {
      softwareVersion: "pytorch-1.6"
    },
    imageTag: "r1.6",
  },
  PyTorchGkePodTest:: common.PyTorchGkePodTest {
    frameworkPrefix: "pt-1.6",
    tpuSettings+: {
      softwareVersion: "pytorch-1.6"
    },
    imageTag: "r1.6",
  },
  Functional:: mixins.Functional {
    # Run at 2:00 UTC daily.
    schedule: "0 2 * * *",
    tpuSettings+: {
      preemptible: false,
    },
  },
  Convergence:: mixins.Convergence {
    # Run at 2:30 UTC on Tuesday and Friday.
    schedule: "30 2 * * 2,4",
  },
  datasetsVolume: volumes.PersistentVolumeSpec {
    name: "pytorch-datasets-claim",
    mountPath: "/datasets",
  },
}
