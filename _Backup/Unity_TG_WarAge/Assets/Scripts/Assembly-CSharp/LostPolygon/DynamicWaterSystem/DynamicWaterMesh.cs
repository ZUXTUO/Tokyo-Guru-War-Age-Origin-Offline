using UnityEngine;

namespace LostPolygon.DynamicWaterSystem
{
	public class DynamicWaterMesh
	{
		private readonly Vector2Int _grid;

		private readonly float _nodeSize;

		private readonly Vector2 _size;

		private readonly IDynamicWaterSettings _settings;

		private readonly Mesh _mesh;

		private bool _isDirty;

		private MeshStruct _meshStruct;

		public bool IsDirty
		{
			get
			{
				return _isDirty;
			}
			set
			{
				_isDirty = value;
			}
		}

		public bool IsReady { get; private set; }

		public Mesh Mesh
		{
			get
			{
				return _mesh;
			}
		}

		public DynamicWaterMesh(IDynamicWaterSettings settings)
		{
			IsReady = false;
			_settings = settings;
			_grid = settings.GridSize;
			_nodeSize = settings.NodeSize;
			_size = settings.Size;
			_mesh = new Mesh
			{
				name = "DynamicWaterMesh"
			};
			_mesh.MarkDynamic();
			AllocateMeshArrays();
			CreateMeshGrid();
			AssignMesh();
			_mesh.RecalculateBounds();
			IsReady = true;
		}

		public void FreeMesh()
		{
			if (_mesh != null)
			{
				Object.DestroyImmediate(_mesh);
			}
		}

		private void AssignMesh()
		{
			_mesh.vertices = _meshStruct.Vertices;
			_mesh.normals = _meshStruct.Normals;
			if (_settings.SetTangents)
			{
				_mesh.tangents = _meshStruct.Tangents;
			}
			_mesh.uv = _meshStruct.UV;
			_mesh.colors32 = _meshStruct.Colors32;
			_mesh.triangles = _meshStruct.Triangles;
			_mesh.RecalculateBounds();
			_meshStruct.Tangents = null;
			_meshStruct.Triangles = null;
			_meshStruct.UV = null;
			_meshStruct.Colors32 = null;
		}

		private void CreateMeshGrid()
		{
			Vector2 size = _size;
			float num = 1f / (size.x / _nodeSize);
			Vector2 size2 = _size;
			float num2 = 1f / (size2.y / _nodeSize);
			Color32 color = new Color32(byte.MaxValue, byte.MaxValue, byte.MaxValue, byte.MaxValue);
			Vector3 up = Vector3.up;
			bool setTangents = _settings.SetTangents;
			Vector4 vector = new Vector4(1f, 0f, 0f, 1f);
			int num3 = 0;
			int num4 = 0;
			while (true)
			{
				int num5 = num4;
				Vector2Int grid = _grid;
				if (num5 >= grid.y)
				{
					break;
				}
				int num6 = 0;
				while (true)
				{
					int num7 = num6;
					Vector2Int grid2 = _grid;
					if (num7 >= grid2.x)
					{
						break;
					}
					int num8 = num4;
					Vector2Int grid3 = _grid;
					int num9 = num8 * grid3.x + num6;
					_meshStruct.Vertices[num9].x = (float)num6 * _nodeSize;
					_meshStruct.Vertices[num9].y = 0f;
					_meshStruct.Vertices[num9].z = (float)num4 * _nodeSize;
					int num10 = num4;
					Vector2Int grid4 = _grid;
					if (num10 < grid4.y - 1)
					{
						int num11 = num6;
						Vector2Int grid5 = _grid;
						if (num11 < grid5.x - 1)
						{
							int[] triangles = _meshStruct.Triangles;
							int num12 = num3;
							int num13 = num4;
							Vector2Int grid6 = _grid;
							triangles[num12] = num13 * grid6.x + num6;
							int[] triangles2 = _meshStruct.Triangles;
							int num14 = num3 + 1;
							int num15 = num4 + 1;
							Vector2Int grid7 = _grid;
							triangles2[num14] = num15 * grid7.x + num6;
							int[] triangles3 = _meshStruct.Triangles;
							int num16 = num3 + 2;
							int num17 = num4;
							Vector2Int grid8 = _grid;
							triangles3[num16] = num17 * grid8.x + num6 + 1;
							int[] triangles4 = _meshStruct.Triangles;
							int num18 = num3 + 3;
							int num19 = num4 + 1;
							Vector2Int grid9 = _grid;
							triangles4[num18] = num19 * grid9.x + num6;
							int[] triangles5 = _meshStruct.Triangles;
							int num20 = num3 + 4;
							int num21 = num4 + 1;
							Vector2Int grid10 = _grid;
							triangles5[num20] = num21 * grid10.x + num6 + 1;
							int[] triangles6 = _meshStruct.Triangles;
							int num22 = num3 + 5;
							int num23 = num4;
							Vector2Int grid11 = _grid;
							triangles6[num22] = num23 * grid11.x + num6 + 1;
							num3 += 6;
						}
					}
					float num24 = num;
					float num25 = num2;
					_meshStruct.UV[num9].x = (float)num6 * num24;
					_meshStruct.UV[num9].y = (float)num4 * num25;
					_meshStruct.Colors32[num9] = color;
					_meshStruct.Normals[num9] = up;
					if (setTangents)
					{
						_meshStruct.Tangents[num9] = vector;
					}
					float x = _meshStruct.Vertices[num9].x;
					Vector2 size3 = _size;
					if (x > size3.x)
					{
						Vector2 size4 = _size;
						float num26 = (size4.x - _meshStruct.Vertices[num9].x) / _nodeSize;
						_meshStruct.UV[num9].x -= num24 * num26;
						Vector3 reference = _meshStruct.Vertices[num9];
						Vector2 size5 = _size;
						reference.x = size5.x;
					}
					float z = _meshStruct.Vertices[num9].z;
					Vector2 size6 = _size;
					if (z > size6.y)
					{
						Vector2 size7 = _size;
						float num26 = (size7.y - _meshStruct.Vertices[num9].z) / _nodeSize;
						_meshStruct.UV[num9].y -= num25 * num26;
						Vector3 reference2 = _meshStruct.Vertices[num9];
						Vector2 size8 = _size;
						reference2.z = size8.y;
					}
					Vector2 size9 = _size;
					if (size9.x - _meshStruct.Vertices[num9].x < _nodeSize)
					{
						Vector2 size10 = _size;
						float num26 = (size10.x - _meshStruct.Vertices[num9].x) / _nodeSize;
						_meshStruct.UV[num9].x += num24 * num26;
						Vector3 reference3 = _meshStruct.Vertices[num9];
						Vector2 size11 = _size;
						reference3.x = size11.x;
					}
					Vector2 size12 = _size;
					if (size12.y - _meshStruct.Vertices[num9].z < _nodeSize)
					{
						Vector2 size13 = _size;
						float num26 = (size13.y - _meshStruct.Vertices[num9].z) / _nodeSize;
						_meshStruct.UV[num9].y += num25 * num26;
						Vector3 reference4 = _meshStruct.Vertices[num9];
						Vector2 size14 = _size;
						reference4.z = size14.y;
					}
					num6++;
				}
				num4++;
			}
		}

		private void AllocateMeshArrays()
		{
			Vector2Int grid = _grid;
			int x = grid.x;
			Vector2Int grid2 = _grid;
			int num = x * grid2.y;
			_meshStruct.Vertices = new Vector3[num];
			_meshStruct.Normals = new Vector3[num];
			if (_settings.SetTangents)
			{
				_meshStruct.Tangents = new Vector4[num];
			}
			_meshStruct.Colors32 = new Color32[num];
			_meshStruct.UV = new Vector2[num];
			MeshStruct meshStruct = _meshStruct;
			Vector2Int grid3 = _grid;
			int num2 = grid3.x - 1;
			Vector2Int grid4 = _grid;
			meshStruct.Triangles = new int[num2 * (grid4.y - 1) * 2 * 3];
			_isDirty = true;
		}

		public void UpdateMesh(float[] field, bool[] fieldObstruction)
		{
			if (!_isDirty || !IsReady)
			{
				return;
			}
			bool flag = fieldObstruction == null;
			bool calculateNormals = _settings.CalculateNormals;
			bool useFakeNormals = _settings.UseFakeNormals;
			bool normalizeFakeNormals = _settings.NormalizeFakeNormals;
			Vector3 up = Vector3.up;
			Vector3 vector = up;
			if (!useFakeNormals)
			{
				int num = 0;
				while (true)
				{
					int num2 = num;
					Vector2Int grid = _grid;
					if (num2 >= grid.y)
					{
						break;
					}
					int num3 = num;
					Vector2Int grid2 = _grid;
					int num4 = num3 * grid2.x;
					int num5 = 0;
					while (true)
					{
						int num6 = num5;
						Vector2Int grid3 = _grid;
						if (num6 >= grid3.x)
						{
							break;
						}
						_meshStruct.Vertices[num4].y = field[num4];
						num4++;
						num5++;
					}
					num++;
				}
			}
			else
			{
				int num7 = 0;
				FastFunctions.FloatIntUnion floatIntUnion = default(FastFunctions.FloatIntUnion);
				while (true)
				{
					int num8 = num7;
					Vector2Int grid4 = _grid;
					if (num8 >= grid4.y)
					{
						break;
					}
					int num9 = num7;
					Vector2Int grid5 = _grid;
					int num10 = num9 * grid5.x;
					int num11 = 0;
					while (true)
					{
						int num12 = num11;
						Vector2Int grid6 = _grid;
						if (num12 >= grid6.x)
						{
							break;
						}
						if (num11 != 0 && num7 != 0)
						{
							int num13 = num11;
							Vector2Int grid7 = _grid;
							if (num13 < grid7.x - 1)
							{
								int num14 = num7;
								Vector2Int grid8 = _grid;
								if (num14 < grid8.y - 1)
								{
									if (!flag && fieldObstruction[num10])
									{
										vector = up;
									}
									else
									{
										float num15 = ((!(field[num10] > 0f)) ? (0f - field[num10]) : field[num10]);
										if (num15 > 0.0001f)
										{
											vector.x = (field[num10 - 1] - field[num10 + 1]) * 2f;
											float[] obj = field;
											int num16 = num10;
											Vector2Int grid9 = _grid;
											float num17 = obj[num16 - grid9.x];
											float[] obj2 = field;
											int num18 = num10;
											Vector2Int grid10 = _grid;
											vector.z = (num17 - obj2[num18 + grid10.x]) * 2f;
											vector.y = ((!(field[num10] > 1f)) ? 1f : field[num10]);
										}
										else
										{
											vector = up;
										}
									}
									if (normalizeFakeNormals)
									{
										float num19 = vector.x * vector.x + vector.y * vector.y + vector.z * vector.z;
										floatIntUnion.i = 0;
										floatIntUnion.f = num19;
										float num20 = 0.5f * num19;
										floatIntUnion.i = 1597463007 - (floatIntUnion.i >> 1);
										num19 = floatIntUnion.f * (1.5f - num20 * floatIntUnion.f * floatIntUnion.f);
										vector.x *= num19;
										vector.y *= num19;
										vector.z *= num19;
									}
									goto IL_02c4;
								}
							}
						}
						vector = up;
						goto IL_02c4;
						IL_02c4:
						_meshStruct.Normals[num10] = vector;
						_meshStruct.Vertices[num10].y = field[num10];
						num10++;
						num11++;
					}
					num7++;
				}
			}
			_mesh.vertices = _meshStruct.Vertices;
			if (calculateNormals)
			{
				if (useFakeNormals)
				{
					_mesh.normals = _meshStruct.Normals;
				}
				else
				{
					_mesh.RecalculateNormals();
				}
			}
			_isDirty = false;
		}
	}
}
